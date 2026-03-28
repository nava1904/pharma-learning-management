# UI/UX QA Checklist

## Typography and readability
- [ ] No user-facing text below 14px.
- [ ] Labels and body text are consistently 15-16px where possible.
- [ ] No compressed table text or clipped controls.

## Layout consistency
- [ ] Search fields are usable (not tiny) and aligned with page actions.
- [ ] Tables stretch to available width and support horizontal scroll when needed.
- [ ] Section cards use consistent spacing, heading hierarchy, and borders.

## Responsive behavior
- [ ] Mobile (`<768`): no overflow in headers, controls, or table actions.
- [ ] Tablet (`768-1023`): side panels stack where needed; dialogs fit viewport.
- [ ] Desktop (`>=1024`): shell nav and tables render full-width with balanced spacing.

## Consumer-focused content
- [ ] Remove technical fallback strings like `Course #123` / `User #12` / internal IDs.
- [ ] Replace technical labels with human-facing copy (e.g., Assigned course).
- [ ] Empty states and errors are clear and task-oriented.

## Regression checks
- [ ] Employee: assigned training -> start training -> no missing-version error.
- [ ] Trainer: assessment builder and matrix screens render without overflow.
- [ ] Admin: access review and certificates screens are readable and responsive.
