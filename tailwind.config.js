// const easing = "cubic-bezier(.49,1.64,.58,1.04)";
const easing = "cubic-bezier(0.49, 1.53, 0.55, 1)";

/** @type {import('tailwindcss').Config} */
module.exports = {
  content: ["./src/**/*.purs"],
  theme: {
    extend: {
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
    },
  },
  plugins: [],
};
