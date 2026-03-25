'use client'

import { useEffect, useState } from 'react'
import Image from 'next/image'

export function SplashScreen() {
  const [isMounted, setIsMounted] = useState(true)
  const [isExiting, setIsExiting] = useState(false)

  useEffect(() => {
    const minDisplayMs = 1800
    const exitDurationMs = 520
    const startedAt = Date.now()

    const beginExit = () => {
      const elapsed = Date.now() - startedAt
      const remaining = Math.max(0, minDisplayMs - elapsed)

      window.setTimeout(() => {
        setIsExiting(true)
        window.setTimeout(() => {
          setIsMounted(false)
        }, exitDurationMs)
      }, remaining)
    }

    if (document.readyState === 'complete') {
      beginExit()
    } else {
      window.addEventListener('load', beginExit, { once: true })
    }

    return () => {
      window.removeEventListener('load', beginExit)
    }
  }, [])

  useEffect(() => {
    if (!isMounted) {
      document.body.classList.remove('splash-active')
      return
    }

    document.body.classList.add('splash-active')
    return () => {
      document.body.classList.remove('splash-active')
    }
  }, [isMounted])

  if (!isMounted) return null

  return (
    <div
      className={`fixed inset-0 z-50 flex items-center justify-center splash-overlay ${
        isExiting ? 'splash-overlay-exit' : ''
      }`}
      aria-hidden
    >
      <div className={`splash-logo-shell ${isExiting ? 'splash-logo-exit' : ''}`}>
        <Image
          src="/unycomb-logo-transparent.png"
          alt="Unycomb"
          width={128}
          height={128}
          priority
          className="h-20 w-20 md:h-24 md:w-24 splash-logo-spin"
        />
      </div>
    </div>
  )
}
