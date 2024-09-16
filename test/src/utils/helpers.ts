import path from "path";

export const resolvePath = (filePath: string) => {
  if (filePath.startsWith("@/")) {
    return require.resolve(filePath);
  }
  return path.resolve(__dirname, filePath);
};
