// const easing = "cubic-bezier(.49,1.64,.58,1.04)";
const easing = "cubic-bezier(0.49, 1.53, 0.55, 1)";

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.purs"],
  theme: {
    extend: {
      letterSpacing: {
        tightest: "-.075em",
      },
      colors: {
        "midnight-blue": "#0c4c6f",
        "pale-blue": "#d8e7ee",
      },
      animation: {
        "pop-out": `pop-size 1s ${easing}, pop-angle 1s 0.05s ${easing}`,
      },
      keyframes: {
        "pop-size": {
          from: {
            scale: 0,
          },
        },
        "pop-angle": {
          from: {
            transform: "rotate(calc(360deg * 1.5))",
          },
        },
      },
      fontFamily: {
        Oxygen: ["Oxygen", "sans-serif"],
        Quicksand: ["Quicksand", "sans-serif"],
      },
    },
  },
  plugins: [],
};
