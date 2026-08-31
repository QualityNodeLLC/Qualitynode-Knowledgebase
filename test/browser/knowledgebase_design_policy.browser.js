/**
 * Browser-computed policy check for any production knowledge-base route.
 *
 * Playwright usage:
 *   import { assertKnowledgebaseDesignPolicy } from './knowledgebase_design_policy.browser.js';
 *   await assertKnowledgebaseDesignPolicy(page);
 */
export async function assertKnowledgebaseDesignPolicy(page) {
    await page.locator('#arcane-root').waitFor({ state: 'visible' });

    const violations = await page.evaluate(() => {
        const scope = document.querySelector('#arcane-root');
        if (!scope) return ['page is missing #arcane-root'];

        const surfaceSelector = [
            '.kb-card',
            '.kb-tile',
            '.kb-callout',
            '.kb-banner',
            '.kb-panel',
            '.kb-frame',
            '.kb-update',
            '.kb-resource',
            '.kb-field',
            '.kb-view',
            '.kb-landing-card',
            '.kb-code-group',
            '.kb-endpoint',
            '.kb-accordion',
            '.kb-rating',
            '.markdown-alert',
            '[data-surface]',
            '[data-arcane-surface]',
            '[class~="card"]',
            '[class~="tile"]',
            '[class~="panel"]',
            '[class*="badge"]',
            '[class*="tag"]',
        ].join(',');
        const surfaces = [...scope.querySelectorAll(surfaceSelector)];
        const controls = [...scope.querySelectorAll([
            'button',
            'a',
            'summary',
            'input',
            'select',
            'textarea',
            '[role="button"]',
            '[role="link"]',
            '[role="tab"]',
        ].join(','))];
        const stateTargets = [...scope.querySelectorAll('.search-results, .kb-sidebar')];
        const targets = [...new Set([...surfaces, ...controls, ...stateTargets])];
        const compactIconTargets = [...new Set([
            ...controls,
            ...surfaces.filter((element) => [...element.classList].some(
                (name) => /(?:^|-)(?:badge|tag)$/.test(name),
            )),
        ])];
        const failures = [];

        const label = (element) => {
            const className = typeof element.className === 'string'
                ? element.className.trim().replace(/\s+/g, '.')
                : '';
            return `${element.tagName.toLowerCase()}${className ? `.${className}` : ''}`;
        };
        const radius = (style) => Math.max(
            Number.parseFloat(style.borderTopLeftRadius) || 0,
            Number.parseFloat(style.borderTopRightRadius) || 0,
            Number.parseFloat(style.borderBottomRightRadius) || 0,
            Number.parseFloat(style.borderBottomLeftRadius) || 0,
        );
        const framed = (style) => [
            style.borderTopWidth,
            style.borderRightWidth,
            style.borderBottomWidth,
            style.borderLeftWidth,
        ].some((width) => Number.parseFloat(width) > 0);
        const transparent = (color) => [
            '',
            'transparent',
            'rgba(0, 0, 0, 0)',
            'rgba(0,0,0,0)',
        ].includes(color);

        for (const element of targets) {
            const style = getComputedStyle(element);
            const rect = element.getBoundingClientRect();
            const elementRadius = radius(style);
            const name = label(element);
            const isCircle = rect.width > 0
                && Math.abs(rect.width - rect.height) < 1
                && elementRadius >= (rect.height / 2) - 1;

            if (!isCircle && rect.height > 0 && rect.width > rect.height * 1.25
                && elementRadius >= (rect.height / 2) - 1) {
                failures.push(`${name}: pill radius`);
            }
            const radiusLimit = controls.includes(element) ? 6 : 8;
            if (!isCircle && elementRadius > radiusLimit) {
                failures.push(`${name}: radius exceeds ${radiusLimit}px`);
            }
            if (style.backgroundImage !== 'none') {
                failures.push(`${name}: decorative background image or gradient`);
            }
            const backdropFilter = style.backdropFilter || style.webkitBackdropFilter || 'none';
            if (backdropFilter !== 'none') {
                failures.push(`${name}: backdrop filter`);
            }
            if (style.boxShadow !== 'none') {
                failures.push(`${name}: decorative shadow or glow`);
            }

            if (!isCircle && elementRadius > 0) {
                const sides = [
                    `${style.borderTopWidth}|${style.borderTopStyle}|${style.borderTopColor}`,
                    `${style.borderRightWidth}|${style.borderRightStyle}|${style.borderRightColor}`,
                    `${style.borderBottomWidth}|${style.borderBottomStyle}|${style.borderBottomColor}`,
                    `${style.borderLeftWidth}|${style.borderLeftStyle}|${style.borderLeftColor}`,
                ];
                if (new Set(sides).size > 1) {
                    failures.push(`${name}: directional border on rounded element`);
                }
            }
        }

        for (const surface of surfaces) {
            if (!framed(getComputedStyle(surface))) continue;
            let parent = surface.parentElement?.closest(surfaceSelector);
            while (parent && scope.contains(parent)) {
                if (framed(getComputedStyle(parent))) {
                    failures.push(`${label(surface)}: framed inside ${label(parent)}`);
                    break;
                }
                parent = parent.parentElement?.closest(surfaceSelector);
            }
        }

        for (const element of compactIconTargets) {
            const visibleIcons = [...element.querySelectorAll('i, svg, img')].filter(
                (icon) => {
                    const style = getComputedStyle(icon);
                    const rect = icon.getBoundingClientRect();
                    return style.display !== 'none'
                        && style.visibility !== 'hidden'
                        && Number.parseFloat(style.opacity || '1') > 0
                        && rect.width > 0
                        && rect.height > 0;
                },
            );
            if (visibleIcons.length > 1) {
                failures.push(`${label(element)}: more than one semantic icon`);
            }
        }

        for (const element of targets) {
            const style = getComputedStyle(element);
            if (radius(style) === 0) continue;

            for (const pseudo of ['::before', '::after']) {
                const pseudoStyle = getComputedStyle(element, pseudo);
                const hasGeometry = pseudoStyle.display !== 'none'
                    && pseudoStyle.visibility !== 'hidden'
                    && ((Number.parseFloat(pseudoStyle.width) || 0) > 0
                        || (Number.parseFloat(pseudoStyle.height) || 0) > 0);
                const hasContent = !['none', 'normal', '', '""'].includes(
                    pseudoStyle.content,
                );
                const borderPaint = [
                    ['borderTopWidth', 'borderTopColor'],
                    ['borderRightWidth', 'borderRightColor'],
                    ['borderBottomWidth', 'borderBottomColor'],
                    ['borderLeftWidth', 'borderLeftColor'],
                ].some(([width, color]) => Number.parseFloat(pseudoStyle[width]) > 0
                    && !transparent(pseudoStyle[color]));
                const hasPaint = pseudoStyle.backgroundImage !== 'none'
                    || !transparent(pseudoStyle.backgroundColor)
                    || pseudoStyle.boxShadow !== 'none'
                    || pseudoStyle.filter !== 'none'
                    || pseudoStyle.borderImageSource !== 'none'
                    || pseudoStyle.maskImage !== 'none'
                    || pseudoStyle.webkitMaskImage !== 'none'
                    || borderPaint;
                if ((hasContent || hasGeometry) && hasPaint) {
                    failures.push(`${label(element)}: painted ${pseudo} accent on rounded surface`);
                }
            }
        }

        const fontFamily = getComputedStyle(document.body).fontFamily;
        if (!fontFamily.includes('Akzidenz Grotesk Pro')) {
            failures.push(`body does not use the approved local font: ${fontFamily}`);
        }
        for (const link of document.querySelectorAll('link[rel="stylesheet"]')) {
            const href = link.getAttribute('href') || '';
            if (/^https?:\/\//i.test(href)) {
                failures.push(`remote stylesheet: ${href}`);
            }
        }
        const remoteInlineFont = /@font-face\s*\{[\s\S]*?url\(\s*['"]?https?:\/\//gi;
        const remoteFontImport = /@import\s+(?:url\()?\s*['"]?https?:\/\//gi;
        for (const styleElement of document.querySelectorAll('style')) {
            const cssText = styleElement.textContent || '';
            if (remoteInlineFont.test(cssText) || remoteFontImport.test(cssText)) {
                failures.push('inline CSS loads a remote font or stylesheet');
            }
            remoteInlineFont.lastIndex = 0;
            remoteFontImport.lastIndex = 0;
        }

        for (const input of scope.querySelectorAll('[data-kb-search-input]')) {
            const search = input.closest('[data-kb-search]');
            const results = search?.querySelector('[data-kb-search-results]');
            if (input.getAttribute('role') !== 'combobox') {
                failures.push(`${label(input)}: search input is not a combobox`);
            }
            if (!input.getAttribute('aria-label')) {
                failures.push(`${label(input)}: search input has no accessible label`);
            }
            if (!['true', 'false'].includes(input.getAttribute('aria-expanded'))) {
                failures.push(`${label(input)}: search input has no expanded state`);
            }
            if (!results || results.getAttribute('role') !== 'listbox') {
                failures.push(`${label(input)}: search results are not a listbox`);
            } else if (!results.id || input.getAttribute('aria-controls') !== results.id) {
                failures.push(`${label(input)}: search input does not control its result list`);
            }
        }

        for (const toggle of scope.querySelectorAll('[data-kb-sidebar-toggle]')) {
            if (!toggle.getAttribute('aria-label')) {
                failures.push(`${label(toggle)}: sidebar toggle has no accessible label`);
            }
            if (!['true', 'false'].includes(toggle.getAttribute('aria-expanded'))) {
                failures.push(`${label(toggle)}: sidebar toggle has no expanded state`);
            }
            const slot = toggle.closest('[data-kb-style-slot]');
            const sidebar = slot?.querySelector('.kb-sidebar');
            if (!sidebar?.id || toggle.getAttribute('aria-controls') !== sidebar.id) {
                failures.push(`${label(toggle)}: sidebar toggle does not control its drawer`);
            } else if (matchMedia('(max-width: 900px)').matches
                && (toggle.getAttribute('aria-expanded') === 'true')
                    !== sidebar.classList.contains('open')) {
                failures.push(`${label(toggle)}: sidebar expanded state is out of sync`);
            }
        }

        for (const button of scope.querySelectorAll('.copy-code-btn')) {
            if (!button.getAttribute('aria-label')) {
                failures.push(`${label(button)}: copy control has no accessible label`);
            }
        }

        if (matchMedia('(max-width: 900px)').matches) {
            for (const sidebar of scope.querySelectorAll('.kb-sidebar:not(.open)')) {
                if (!sidebar.hasAttribute('inert') || sidebar.getAttribute('aria-hidden') !== 'true') {
                    failures.push(`${label(sidebar)}: closed mobile sidebar remains interactive`);
                }
            }
        }

        return [...new Set(failures)];
    });

    if (violations.length > 0) {
        throw new Error(`Knowledgebase design policy violations:\n${violations.join('\n')}`);
    }
}
