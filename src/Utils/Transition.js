export const useTransition = (body) => () => {
  if (document.startViewTransition) {
    document.startViewTransition(body);
  } else {
    body();
  }
};
