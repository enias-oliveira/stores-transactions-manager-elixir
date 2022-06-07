/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: {
    outputStandalone: true,
  },
  async rewrites() {
    return [
      {
        source: '/:path*',
        destination: `${process.env.BACKEND_SERVICE_URL}/:path*` // Proxy to Backend
      }
    ]
  }
}

module.exports = nextConfig
