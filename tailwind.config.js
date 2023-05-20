// const easing = "cubic-bezier(.49,1.64,.58,1.04)";
// const easing = "cubic-bezier(0.49, 1.53, 0.55, 1)";
const easing = "cubic-bezier(0, 1, 1, 1)";

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.purs"],
  theme: {
    extend: {
      letterSpacing: {
        tightest: "-.075em",
        supertight: "-.125em",
      },
      colors: {
        "midnight-blue": "#0c4c6f",
        "pale-blue": "#d8e7ee",
      },
      animation: {
        "top-line": `top-line 0.5s 0.1s ${easing} backwards`,
        "top-left": `top-left 0.9s 0.4s ${easing} backwards`,
        "top-right-1": `top-right 0.8s 0.5s ${easing} backwards`,
        "top-right-2": `top-right 0.7s 0.6s ${easing} backwards`,
      },
      keyframes: {
        "top-line": {
          from: {
            transform: "scaleY(0)",
          },
        },
        "top-left": {
          from: {
            transform: "translateX(120%)",
          },
        },
        "top-right": {
          from: {
            transform: "translateX(-120%)",
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
