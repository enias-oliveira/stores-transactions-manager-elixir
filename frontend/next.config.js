/** @type {import('next').NextConfig} */
const nextConfig = {
  reactStrictMode: true,
  experimental: {
    outputStandalone: true,
  },
  async rewrites() {
    return [
      {
        source: '/api/:path*',
        destination: 'http://localhost:5500/:path*' // Proxy to Backend
      }
    ]
  }
}

module.exports = nextConfig
