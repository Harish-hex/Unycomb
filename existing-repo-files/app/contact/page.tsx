"use client"

import type React from "react"

import { Navbar } from "@/components/navbar"
import { Footer } from "@/components/footer"
import { useState } from "react"
import { ArrowRight, Mail, MapPin, Phone } from "lucide-react"

export default function ContactPage() {
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    school: "",
    interest: "",
    message: "",
  })

  const handleSubmit = (e: React.FormEvent) => {
    e.preventDefault()
    console.log(formData)
  }

  return (
    <main className="min-h-screen bg-[#FFA500]">
      <Navbar />

      <section className="pt-32 pb-16 px-4 md:px-8">
        <div className="flex items-end justify-between gap-8">
          <div>
            <h1 className="font-serif text-[12vw] md:text-[8vw] leading-[0.85] uppercase tracking-tighter text-black">
              Get in
              <br />
              <span className="text-black">Touch</span>
            </h1>
            <p className="font-mono text-black/70 mt-8 max-w-xl">
              Building something on campus, looking for teammates, or exploring a partnership with Unycomb? Reach out and we&apos;ll help you find the fastest path to ship.
            </p>
          </div>
          <img src="/unycomb-logo-transparent.png" alt="Unycomb" className="w-20 h-20 md:w-32 md:h-32 mb-4" />
        </div>
      </section>

      <section className="px-4 md:px-8 pb-24">
        <div className="grid grid-cols-1 lg:grid-cols-2 gap-16">
          <form onSubmit={handleSubmit} className="space-y-8">
            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label className="font-mono text-xs uppercase mb-2 block text-black">Name *</label>
                <input
                  type="text"
                  required
                  value={formData.name}
                  onChange={(e) => setFormData({ ...formData, name: e.target.value })}
                  className="w-full bg-transparent border-b-2 border-black py-3 font-mono focus:outline-none focus:border-black/50 transition-colors text-black placeholder:text-black/50"
                  placeholder="John Doe"
                />
              </div>
              <div>
                <label className="font-mono text-xs uppercase mb-2 block text-black">Email *</label>
                <input
                  type="email"
                  required
                  value={formData.email}
                  onChange={(e) => setFormData({ ...formData, email: e.target.value })}
                  className="w-full bg-transparent border-b-2 border-black py-3 font-mono focus:outline-none focus:border-black/50 transition-colors text-black placeholder:text-black/50"
                  placeholder="john@college.edu"
                />
              </div>
            </div>

            <div className="grid grid-cols-1 md:grid-cols-2 gap-6">
              <div>
                <label className="font-mono text-xs uppercase mb-2 block text-black">College/University</label>
                <input
                  type="text"
                  value={formData.school}
                  onChange={(e) => setFormData({ ...formData, school: e.target.value })}
                  className="w-full bg-transparent border-b-2 border-black py-3 font-mono focus:outline-none focus:border-black/50 transition-colors text-black placeholder:text-black/50"
                  placeholder="Your College"
                />
              </div>
              <div>
                <label className="font-mono text-xs uppercase mb-2 block text-black">Interest</label>
                <select
                  value={formData.interest}
                  onChange={(e) => setFormData({ ...formData, interest: e.target.value })}
                  className="w-full bg-transparent border-b-2 border-black py-3 font-mono focus:outline-none focus:border-black/50 transition-colors cursor-pointer text-black"
                >
                  <option value="">Select interest</option>
                  <option value="finding-team">Finding a Team</option>
                  <option value="hackathons">Hackathons</option>
                  <option value="building">Building & Shipping</option>
                  <option value="mentorship">Mentorship</option>
                  <option value="partnership">Partnership</option>
                  <option value="other">Other</option>
                </select>
              </div>
            </div>

            <div>
              <label className="font-mono text-xs uppercase mb-2 block text-black">Message *</label>
              <textarea
                required
                value={formData.message}
                onChange={(e) => setFormData({ ...formData, message: e.target.value })}
                rows={5}
                className="w-full bg-transparent border-2 border-black p-4 font-mono focus:outline-none focus:border-black/50 transition-colors resize-none text-black placeholder:text-black/50"
                placeholder="Tell us what you're building and how we can help..."
              />
            </div>

            <button
              type="submit"
              className="group flex items-center gap-4 bg-black text-[#FFA500] px-8 py-4 font-mono uppercase hover:bg-black/80 transition-colors"
            >
              Send Message
              <ArrowRight className="group-hover:translate-x-2 transition-transform" size={20} />
            </button>
          </form>

          <div className="space-y-12">
            <div>
              <h3 className="font-serif text-2xl uppercase mb-6 text-black">Contact Info</h3>
              <div className="space-y-4">
                <a
                  href="mailto:hello@unycomb.com"
                  className="flex items-center gap-4 font-mono text-black hover:text-black/70 transition-colors"
                >
                  <Mail size={20} />
                  hello@unycomb.com
                </a>
                <a
                  href="tel:+1234567890"
                  className="flex items-center gap-4 font-mono text-black hover:text-black/70 transition-colors"
                >
                  <Phone size={20} />
                  +1 (234) 567-890
                </a>
                <div className="flex items-center gap-4 font-mono text-black">
                  <MapPin size={20} />
                  San Francisco, CA
                </div>
              </div>
            </div>

            <div>
              <h3 className="font-serif text-2xl uppercase mb-6 text-black">Join the Community</h3>
              <p className="font-mono text-black/70">
                Follow along for product updates, builder spotlights, and upcoming hackathons your team can join.
              </p>
              <div className="flex gap-4 mt-4">
                {["Twitter", "Discord", "Instagram", "LinkedIn"].map((social) => (
                  <a
                    key={social}
                    href="#"
                    className="font-mono text-xs uppercase text-black hover:text-black/70 transition-colors"
                  >
                    {social}
                  </a>
                ))}
              </div>
            </div>

            <div className="border-2 border-black p-8 bg-black text-[#FFA500]">
              <h3 className="font-serif text-2xl uppercase mb-4">Quick Response</h3>
              <p className="font-mono text-sm opacity-90">
                We usually reply within 24 hours. If this is about community partnerships, events, or campus launches, mention it so we can route it faster.
              </p>
            </div>
          </div>
        </div>
      </section>

      <Footer />
    </main>
  )
}
