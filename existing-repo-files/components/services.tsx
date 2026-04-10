"use client"

import { Star } from "lucide-react"
import { ServiceCard } from "./service-card"

const services = [
  {
    title: "Team Builder",
    features: [
      {
        label: "Match Making",
        description: "Pairs you with builders whose goals, skills, and pace match your own so teams click faster.",
      },
      {
        label: "AI Powered",
        description: "Uses profile and activity signals to surface stronger team suggestions over time.",
      },
      {
        label: "Community",
        description: "Connects you to active circles where collaborators, mentors, and ideas are always moving.",
      },
    ],
  },
  {
    title: "Hackathon Hub",
    features: [
      {
        label: "Discovery",
        description: "Find relevant hackathons by theme, timeline, and difficulty in one place.",
      },
      {
        label: "Tracking",
        description: "Keeps deadlines, submissions, and milestones visible so your team stays on schedule.",
      },
      {
        label: "Opportunities",
        description: "Highlights prizes, internships, and follow-on programs tied to each event.",
      },
    ],
  },
  {
    title: "Builder Feed",
    features: [
      {
        label: "Progress Sharing",
        description: "Post build logs and updates so others can follow your momentum and give feedback.",
      },
      {
        label: "Showcase",
        description: "Turn your projects into clean, shareable highlights for peers, judges, and recruiters.",
      },
      {
        label: "Networking",
        description: "Start conversations with builders who work on similar ideas and complementary stacks.",
      },
    ],
  },
  {
    title: "Learning",
    features: [
      {
        label: "Skill Development",
        description: "Guides you through focused growth paths to build practical strengths quickly.",
      },
      {
        label: "Real-world",
        description: "Centers your learning around production-style problems, not just theory.",
      },
      {
        label: "Hands-on",
        description: "Helps you learn by shipping through exercises and collaborative mini-builds.",
      },
    ],
  },
]

export function Services() {
  return (
    <section className="bg-black min-h-screen py-32 relative">
      <div className="container mx-auto px-4 mb-20 flex items-end justify-between">
        <h2 className="font-serif text-[12vw] leading-none text-white uppercase font-black">Platform</h2>
        <Star className="w-24 h-24 text-[#FFA500] animate-pulse hidden md:block" fill="currentColor" />
      </div>

      <div className="flex flex-col">
        {services.map((s, i) => (
          <ServiceCard key={i} number={`0${i + 1}`} title={s.title} features={s.features} />
        ))}
      </div>
    </section>
  )
}
