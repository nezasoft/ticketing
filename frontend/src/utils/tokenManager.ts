// tokenManager.ts
let memoryToken: string | null = null;

export const tokenManager = {
  /**
   * Save token in memory + localStorage
   */
  setToken: (token: string) => {
    memoryToken = token;
    localStorage.setItem("token", token);
  },

  /**
   * Get token from memory, fallback to localStorage.
   * If found in localStorage, hydrate memory automatically.
   */
  getToken: (): string | null => {
    if (memoryToken) {
      return memoryToken;
    }
    const saved = localStorage.getItem("token");
    if (saved) {
      memoryToken = saved; // hydrate memory
      return saved;
    }
    return null;
  },

  /**
   * Clear token from both memory + localStorage
   */
  clear: () => {
    memoryToken = null;
    localStorage.removeItem("token");
  },
};
