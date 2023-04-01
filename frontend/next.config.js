const nextConfig = {
    // override `pages/api`
    async rewrites() {
      return [
        {
          source: "/api/:path*",
          destination: "http://localhost:5000/api/:path*",
        },
      ];
    },
  };
  
  module.exports = nextConfig;