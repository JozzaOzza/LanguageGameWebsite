const nextConfig = {
    // override `pages/api`
    async rewrites() {
      return [
        {
          source: "/api",
          destination: "http://localhost:5000/api",
        },
      ];
    },
  };
  
  module.exports = nextConfig;