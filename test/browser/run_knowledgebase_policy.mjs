import { readFile } from 'node:fs/promises';
import { createRequire } from 'node:module';

const require = createRequire(import.meta.url);
const { chromium } = require('playwright');

const baseUrl = process.env.BASE_URL || 'http://127.0.0.1:8899';
const widths = [375, 768, 1440];
const searchIndex = JSON.parse(
    await readFile(new URL('../../build/jaspr/search-index.json', import.meta.url), 'utf8'),
);
const routes = searchIndex.entries;

const policySource = await readFile(
    new URL('./knowledgebase_design_policy.browser.js', import.meta.url),
    'utf8',
);
const policyModule = await import(
    `data:text/javascript;base64,${Buffer.from(policySource).toString('base64')}`
);
const { assertKnowledgebaseDesignPolicy } = policyModule;

const browser = await chromium.launch({ headless: true });
const failures = [];

const checkState = async (width, label, callback) => {
    try {
        await callback();
    } catch (error) {
        failures.push(`${width}px ${label}: ${error.message}`);
    }
};

try {
    for (const width of widths) {
        const page = await browser.newPage({ viewport: { width, height: 900 } });
        for (const entry of routes) {
            const route = entry.path;
            try {
                const response = await page.goto(`${baseUrl}${route}`, {
                    waitUntil: 'domcontentloaded',
                    timeout: 30_000,
                });
                if (!response || !response.ok()) {
                    throw new Error(`HTTP ${response?.status() ?? 'no response'}`);
                }
                const contentHeading = page.locator('article h1').first();
                if (!await contentHeading.count()) {
                    throw new Error('article heading is missing');
                }
                const documentTitle = await page.title();
                if (!documentTitle.startsWith(entry.title)) {
                    throw new Error(
                        `route identity mismatch: expected "${entry.title}", found "${documentTitle}"`,
                    );
                }
                await assertKnowledgebaseDesignPolicy(page);
            } catch (error) {
                failures.push(`${width}px ${route}: ${error.message}`);
            }
        }
        await page.close();
    }

    for (const width of widths) {
        const statePage = await browser.newPage({ viewport: { width, height: 900 } });
        await statePage.goto(`${baseUrl}/game-servers/minecraft`, {
            waitUntil: 'domcontentloaded',
        });

        await checkState(width, 'sidebar and search states', async () => {
            const sidebarToggle = statePage
                .locator('[data-kb-sidebar-toggle]:visible')
                .first();
            if (await sidebarToggle.count()) {
                await sidebarToggle.click();
                if (await sidebarToggle.getAttribute('aria-expanded') !== 'true') {
                    throw new Error('sidebar did not report its expanded state');
                }
                await assertKnowledgebaseDesignPolicy(statePage);
            } else if (!await statePage.locator('.kb-sidebar:visible').count()) {
                throw new Error('desktop sidebar is not visible');
            }

            const searchInput = statePage
                .locator('[data-kb-search-input]:visible')
                .first();
            if (!await searchInput.count()) {
                throw new Error('search input is missing');
            }
            await searchInput.fill('minecraft');
            await statePage
                .locator('[data-kb-search-results]:visible')
                .first()
                .waitFor({ state: 'visible' });
            await assertKnowledgebaseDesignPolicy(statePage);
            await searchInput.fill('');

            if (await sidebarToggle.count()) {
                await sidebarToggle.click();
                if (await sidebarToggle.getAttribute('aria-expanded') !== 'false') {
                    throw new Error('sidebar did not report its closed state');
                }
                await assertKnowledgebaseDesignPolicy(statePage);
            }
        });

        await checkState(width, 'light and dark theme states', async () => {
            const themeToggle = statePage
                .locator('[data-kb-theme-toggle]:visible')
                .first();
            if (!await themeToggle.count()) {
                throw new Error('theme toggle is missing');
            }
            const html = statePage.locator('html');
            const initialMode = await html.evaluate((element) => (
                element.classList.contains('dark') ? 'dark' : 'light'
            ));

            await themeToggle.click();
            await statePage.waitForFunction((previousMode) => {
                const element = document.documentElement;
                const mode = element.classList.contains('dark') ? 'dark' : 'light';
                return mode !== previousMode;
            }, initialMode);
            await assertKnowledgebaseDesignPolicy(statePage);

            await themeToggle.click();
            await statePage.waitForFunction((expectedMode) => {
                const element = document.documentElement;
                const mode = element.classList.contains('dark') ? 'dark' : 'light';
                return mode === expectedMode;
            }, initialMode);
            await assertKnowledgebaseDesignPolicy(statePage);
        });

        await statePage.close();
    }

    const statePage = await browser.newPage({ viewport: { width: 375, height: 900 } });
    await statePage.goto(`${baseUrl}/`, { waitUntil: 'domcontentloaded' });
    await statePage.evaluate(() => {
        const button = document.createElement('button');
        button.textContent = 'Forbidden radius';
        button.style.borderRadius = '8px';
        document.querySelector('#arcane-root')?.append(button);

        const outer = document.createElement('div');
        outer.setAttribute('data-arcane-surface', 'outer');
        outer.style.border = '1px solid rgb(120, 120, 120)';
        outer.style.padding = '8px';

        const inner = document.createElement('div');
        inner.setAttribute('data-arcane-surface', 'inner');
        inner.style.border = '1px solid rgb(120, 120, 120)';
        inner.textContent = 'Forbidden nested surface';
        outer.append(inner);
        document.querySelector('#arcane-root')?.append(outer);
    });

    let mutationMessage = '';
    try {
        await assertKnowledgebaseDesignPolicy(statePage);
    } catch (error) {
        mutationMessage = error.message;
    }
    for (const expected of ['radius exceeds 6px', 'framed inside']) {
        if (!mutationMessage.includes(expected)) {
            failures.push(`mutation self-test did not reject: ${expected}`);
        }
    }

    await statePage.close();
} finally {
    await browser.close();
}

if (failures.length > 0) {
    throw new Error(`Knowledgebase browser policy failed:\n${failures.join('\n')}`);
}

console.log(
    `Knowledgebase browser policy: PASS (${routes.length} routes at ${widths.length} widths)`,
);
