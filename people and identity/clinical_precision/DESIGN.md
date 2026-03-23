# Clinical Precision Design System

### 1. Overview & Creative North Star
**Creative North Star: The Sovereign Auditor**
Clinical Precision is a high-density, high-stakes design system engineered for the pharmaceutical and compliance industries. It prioritizes information density and uncompromising clarity over decorative flair. The system breaks from standard SaaS templates by adopting a "Sovereign" aesthetic—utilizing a dark, authoritative sidebar against a stark, hyper-clean "white lab" workspace. It uses intentional asymmetry, where the heavy structural left-hand navigation anchors a lightweight, data-rich canvas.

### 2. Colors
The palette is rooted in functional signaling: Compliance Blue (#1565f9), Audit Success (#24a148), and Deviation Red (#da1e28).

- **The "No-Line" Rule:** Sectioning is achieved through background shifts (from `#ffffff` surfaces to `#f4f4f4` gutters) or subtle 1px containers. High-level headers use a faint `#fcfcfc` tint to distinguish control areas from data areas.
- **Surface Hierarchy:** 
    - **Surface Lowest:** Main white workspace cards.
    - **Surface Low (#fcfcfc):** Header backgrounds for tables.
    - **Surface Container (#f4f4f4):** The foundational "bench" color upon which cards sit.
- **The "Glass & Gradient" Rule:** While the system is primarily flat, floating tooltips or mobile overlays should utilize a subtle 10% opacity white overlay on dark backgrounds to maintain the "Sovereign" feel.
- **Signature Textures:** Use 10% opacity tints of primary/success/error colors for state indicators (e.g., `primary/10` for active tags) to avoid visual heaviness.

### 3. Typography
Clinical Precision utilizes a high-contrast typographic scale that ranges from micro-labels to massive status readouts.

**Typographic Rhythm:**
- **Display Status:** 48px / 24px (used for critical KPIs like Audit Scores).
- **Section Headers:** 16px Semibold (for dashboard titles).
- **Data Headers:** 14px Semibold.
- **Primary Interface Text:** 13px (Sidebar links and card titles).
- **Data Row Text:** 12px / 11px (The primary reading size for density).
- **Micro/Mono Labels:** 10px (Used for IDs like `SOP-892` and secondary metadata).

The use of **JetBrains Mono** for IDs and timestamps provides a "technical/validated" feel, ensuring that system-generated data is visually distinct from user-generated content.

### 4. Elevation & Depth
Depth is communicated through stacking rather than shadows. 
- **The Layering Principle:** A three-tier stack—Dark Sidebar (Base), Grey Background (Mid), White Cards (Top).
- **Ambient Shadows:** Only use `shadow-sm` (a very tight, low-blur shadow) to lift actionable cards from the background. 
- **The "Ghost Border":** All cards must have a 1px border of `#e0e0e0`. This mimics the look of a printed laboratory report and reinforces the feeling of "contained" data.

### 5. Components
- **Buttons:** Sharp 2px rounded corners. Primary buttons use the seed blue; secondary buttons are ghost-style with `#e0e0e0` borders.
- **The "Data Row":** Table rows must be exactly 28px in height for maximum density. On hover, rows shift to `#f4f4f4`.
- **Status Pills:** Use a 1.5px dot combined with 10px uppercase text for system statuses (e.g., "System Initialized").
- **KPI Cards:** Feature a top-aligned "Info" icon and a bottom-aligned "View Detail" text link to maximize the vertical scan-line of the numeric value.

### 6. Do's and Don'ts
- **Do:** Use `font-mono` for any system ID, date, or percentage.
- **Do:** Maintain strict 24px (p-6) padding for major containers.
- **Don't:** Use rounded corners larger than 4px (except for the 'pill' status).
- **Don't:** Use vibrant gradients; stick to solid fills or 10% alpha tints.
- **Do:** Use 18px icons for navigation to maintain a compact footprint.