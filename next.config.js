/** @type {import('next').NextConfig} */
const nextConfig = {
  // Note: Static export is not compatible with Supabase server-side features
  // Use Vercel, Railway, or similar platforms for deployment
  images: {
    unoptimized: true,
  },
};

module.exports = nextConfig;
