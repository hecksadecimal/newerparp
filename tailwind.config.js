module.exports = {
  content: [
    './app/views/**/*.html.erb',
    './app/helpers/**/*.rb',
    './app/bbcode/*.rb',
    './bbcode-rails/**/*.rb',
    './app/assets/stylesheets/**/*.css',
    './app/javascript/**/*.js'
  ],
  theme: {
    fontFamily: {
      'sans': ["Courier", "Courier New", "Ricty", "Inconsolata", "monospace"]
    },
    extend: {
      backgroundImage: {
        global: 'var(--background-image)'
      },
      animation: {
        marquee: 'marquee 25s linear infinite',
        marquee2: 'marquee2 25s linear infinite',
      },
      keyframes: {
        marquee: {
          '0%': { transform: 'translateX(0%)' },
          '100%': { transform: 'translateX(-100%)' },
        },
        marquee2: {
          '0%': { transform: 'translateX(100%)' },
          '100%': { transform: 'translateX(0%)' },
        }
      },
    }
  },
  plugins: [
    require("@tailwindcss/typography"), 
    require("daisyui"),
    require("tailwindcss-inner-border"),
  ],
  daisyui: {
    themes: [
      "emerald",
      "light",
      "dark",
      "cupcake",
      "bumblebee",
      "corporate",
      "synthwave",
      "retro",
      "cyberpunk",
      "valentine",
      "halloween",
      "garden",
      "forest",
      "lofi",
      "pastel",
      "fantasy",
      "wireframe",
      "black",
      "luxury",
      "dracula",
      "cmyk",
      "autumn",
      "business",
      "acid",
      "lemonade",
      "night",
      "coffee",
      "winter",
      {
        felt: {
          "primary": "#d9f99d",
          "secondary": "#4ade80",
          "accent": "#a3e635",
          "neutral": "#27e100",
          "neutral-text": "#27e100",
          "neutral-content": "#27e100",
          "base-100": "#000000",
          "base-200": "#156704",
          "base-300": "#4d7c0f",
          "base-content": "#27e100",
          "info": "#ecfccb",
          "success": "#84cc16",
          "warning": "#bef264", 
          "error": "#86efac",

          //"fontFamily": "'Alternian CBB', 'alternianFontOne', TrollType, mono",

          "--rounded-box": "0rem", // border radius rounded-box utility class, used in card and other large boxes
          "--rounded-btn": "0rem", // border radius rounded-btn utility class, used in buttons and similar element
          "--rounded-badge": "0rem", // border radius rounded-badge utility class, used in badges and similar
          "--animation-btn": "0.25s", // duration of animation when you click on button
          "--animation-input": "0.2s", // duration of animation for inputs like checkbox, toggle, radio, etc
          "--btn-text-case": "uppercase", // set default text transform for buttons
          "--btn-focus-scale": "0.95", // scale transform of button when you focus on it
          "--border-btn": "1px", // border width of buttons
          "--tab-border": "1px", // border width of tabs
          "--tab-radius": "0rem", // border radius of tabs

          "--background-image": "var(--felt-background-image)"
        },
      },
    ],
  },
}
