# Snacks Image Test

If `snacks.image` is working, the image below should appear directly inside
Neovim rather than merely displaying its filename.

## Local PNG

![Local test image](./test.png)

## Smaller image using HTML

<img src="./test.png" width="300">

## Remote image

![Neovim logo](https://raw.githubusercontent.com/neovim/neovim.github.io/master/logos/neovim-mark-flat.png)

## Image inside a nested section

> The image below is inside a blockquote.
>
> ![Nested image](./test.png)

## LaTeX test

Inline equation: $E = mc^2$

Display equation:

$$
\int_{-\infty}^{\infty} e^{-x^2}\,dx = \sqrt{\pi}
$$

## End

If you can see the images and rendered equations, the basic Snacks image
integration is functioning.














# H1: Document Title (Stress Testing Markdown & Scientific Rendering)
## H2: Advanced Terminal Engine Validation Document
### H3: Scope: Inline Layouts, Links, Images, and Mathematics

Welcome to the ultimate rendering stress-test file. This document evaluates terminal-based text parsers, UI layout engines, and font rendering layers (like `snacks.nvim`, `md-render.nvim`, and Ghostty).

---

## 1. Typography, Links & Interactive Anchors

This layout contains standard typography structures like **bold text**, *italicized text*, and ***combined bold-italic text***. You can also use ~~strikethrough edits~~ or showcase `inline code blocks`.

### Interactive Reference Matrix
*   **External Web Link:** Learn more about terminal emulation on the [Ghostty Official Website](https://ghostty.org).
*   **Inline Auto-Link:** Raw URLs should automatically become active links: <https://github.com>
*   **Document Anchor Link:** Jump down to the [4. Core Media Layout Testing](#4-core-media-layout-testing-images--videos) section.
*   **Task Lists with Links:**
    *   [x] Core dependencies verified (`curl`, `ffmpeg`, `imagemagick`)
    *   [ ] Read the [snacks.nvim Image API Specs](https://github.com/folke/snacks.nvim) for configuration details.

---

## 2. Advanced Scientific & Mathematical Rendering

This section evaluates your font engine's ability to handle LaTeX equations, complex super/subscripts, symbols, and mathematical matrix grids.

### Inline Expressions
Mathematical symbols should scale and align beautifully inline with regular prose. For instance, evaluating the hypotenuse of a right triangle uses the classic Pythagorean expression $a^2 + b^2 = c^2$. When solving quadratic branches, the roots are computed via the formula $x = \frac{-b \pm \sqrt{b^2 - 4ac}}{2a}$.

### Display Equations (Block Render)
Standalone equations should render centered with proper vertical padding, integration limits, and operator spacing.

#### The Fundamental Theorem of Calculus
$$
\int_{a}^{b} f(x) \,dx = F(b) - F(a)
$$

#### Maxwell's Equations (Electrodynamics Gauss Law)
$$
\nabla \cdot \mathbf{E} = \frac{\rho}{\varepsilon_0}
$$

#### Infinite Series Limit Definitions
$$
\lim_{n \to \infty} \left(1 + \frac{1}{n}\right)^n = e
$$

### Complex Matrix Layouts
This block checks column scaling, bracket rendering, and spacing inside a mathematical matrix array.

$$
\mathbf{A} = \begin{pmatrix}
1 & a_1 & a_2 \\
0 & 1 & a_3 \\
0 & 0 & 1
\end{pmatrix}
$$

### Chemical Engineering Formula Notation
Molecular subscripts and reactions should render clearly without offsetting text lines:

$$\text{H}_2\text{O} + \text{CO}_2 \rightarrow \text{H}_2\text{CO}_3$$

---

## 3. Code Block Highlight Testing

### Lua Module Setup
```lua
-- Simple lua function to evaluate terminal capability pathways
local M = {}

function M.setup(opts)
  opts = opts or {}
  if opts.terminal_graphics then
    print("Forcing Kitty Graphics Protocol execution path...")
  end
end

return M
