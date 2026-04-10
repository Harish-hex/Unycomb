"use client"

import { Marquee } from "./marquee"

export function MarqueeSection() {
  return (
    <section className="bg-black text-[#FFA500] py-20 overflow-hidden -skew-y-2 origin-left">
      <Marquee text="TEAMS • HACKATHONS • BUILDERS •" direction={1} className="opacity-80" />
      <Marquee text="SHIPPING • BUILDING • COMMUNITY •" direction={-1} className="text-white opacity-90" />
    </section>
  )
}
