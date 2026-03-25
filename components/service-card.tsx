"use client"

import { useState } from "react"
import { ArrowUpRight } from "lucide-react"

interface FeatureItem {
  label: string
  description: string
}

interface ServiceCardProps {
  number: string
  title: string
  features: FeatureItem[]
}

export function ServiceCard({ number, title, features }: ServiceCardProps) {
  const [activeFeature, setActiveFeature] = useState<FeatureItem>(features[0])

  return (
    <div
      className="group border-t border-white/20 py-12 hover:bg-white/5 transition-colors duration-500 cursor-pointer"
      onMouseLeave={() => setActiveFeature(features[0])}
    >
      <div className="container mx-auto px-4 flex flex-col md:flex-row md:items-start justify-between gap-8">
        <div className="font-mono text-[#FFA500] text-xl">({number})</div>
        <div className="flex-1">
          <h3 className="font-serif text-6xl md:text-8xl font-bold uppercase text-white mb-4 group-hover:translate-x-4 transition-transform duration-300">
            {title}
          </h3>
          <div className="flex gap-4 flex-wrap">
            {features.map((feature) => (
              <button
                key={feature.label}
                type="button"
                className="px-3 py-1 border border-white/30 rounded-full text-white/60 font-mono text-sm uppercase transition-colors duration-200 hover:text-white hover:border-white/70 focus-visible:text-white focus-visible:border-white/70"
                onMouseEnter={() => setActiveFeature(feature)}
                onFocus={() => setActiveFeature(feature)}
                title={feature.description}
              >
                {feature.label}
              </button>
            ))}
          </div>
          <div className="mt-4 min-h-14">
            <p className="max-w-2xl text-sm md:text-base text-white/85 font-mono leading-relaxed transition-opacity duration-200 opacity-100">
              {activeFeature.description}
            </p>
          </div>
        </div>
        <div className="md:self-center opacity-0 group-hover:opacity-100 transition-opacity duration-300 transform group-hover:rotate-45">
          <ArrowUpRight className="w-20 h-20 text-[#FFA500]" />
        </div>
      </div>
    </div>
  )
}
