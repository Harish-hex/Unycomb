import type React from "react"
import type { Metadata } from "next"
import { Geist_Mono, Playfair_Display } from "next/font/google"
import { Analytics } from "@vercel/analytics/next"
import { SplashScreen } from "@/components/splash-screen"
import "./globals.css"

const _geistMono = Geist_Mono({
  subsets: ["latin"],
  variable: "--font-geist-mono",
})
const _playfair = Playfair_Display({
  subsets: ["latin"],
  variable: "--font-playfair",
})

export const metadata: Metadata = {
  title: "Unycomb | Find Builders, Ship Ideas",
  description: "Platform for college students to find teammates, discover hackathons, and ship real-world projects.",
  generator: "v0.app",
  icons: {
    icon: [
      {
        url: "/icon-light-32x32.png",
        media: "(prefers-color-scheme: light)",
      },
      {
        url: "/icon-dark-32x32.png",
        media: "(prefers-color-scheme: dark)",
      },
      {
        url: "/icon.svg",
        type: "image/svg+xml",
      },
    ],
    apple: "/apple-icon.png",
  },
}

export default function RootLayout({
  children,
}: Readonly<{
  children: React.ReactNode
}>) {
  return (
    <html lang="en" className={`${_geistMono.variable} ${_playfair.variable}`}>
      <body className="font-mono antialiased">
        <SplashScreen />
        {children}
        <Analytics />
      </body>
    </html>
  )
}
