import { Navbar } from "@/components/navbar"
import { Footer } from "@/components/footer"

const team = [
  {
    name: "Alex Chen",
    role: "Creative Director",
    image: "/creative-director-headshot.png",
  },
  {
    name: "Sarah Miller",
    role: "Design Lead",
    image: "/professional-headshot-designer-woman.jpg",
  },
  {
    name: "Marcus Johnson",
    role: "Tech Lead",
    image: "/professional-headshot-developer-man.jpg",
  },
  {
    name: "Emma Wilson",
    role: "Strategy Director",
    image: "/professional-headshot-strategist-woman.jpg",
  },
]

const stats = [
  { value: "150+", label: "Projects Completed" },
  { value: "12", label: "Years Experience" },
  { value: "40+", label: "Team Members" },
  { value: "25", label: "Awards Won" },
]

export default function AboutPage() {
  return (
    <main className="min-h-screen bg-[#FFA500]">
      <Navbar />

      <section className="pt-32 pb-16 px-4 md:px-8">
        <h1 className="font-serif text-[12vw] md:text-[8vw] leading-[0.85] uppercase tracking-tighter text-black">
          About
          <br />
          <span className="text-black">Us</span>
        </h1>
      </section>

      <section className="px-4 md:px-8 pb-24">
        <div className="grid grid-cols-1 md:grid-cols-2 gap-16">
          <div>
            <p className="font-serif text-2xl md:text-4xl leading-tight text-black">
              We are building the default launchpad for student founders, makers, and hackers who want to turn ideas into shipped products.
            </p>
          </div>
          <div className="space-y-6">
            <p className="font-mono text-black/70">
              Unycomb started with one simple problem: talented students had ideas, but not always the right teammates, momentum, or opportunities to move fast.
            </p>
            <p className="font-mono text-black/70">
              We help builders find trusted collaborators, discover hackathons and challenges worth joining, and stay accountable from concept to launch. Our goal is to make shipping with a great team feel normal on every campus.
            </p>
          </div>
        </div>
      </section>

      <section className="px-4 md:px-8 pb-24">
        <h2 className="font-serif text-4xl md:text-6xl uppercase tracking-tight mb-12 text-black">The Team</h2>
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          {team.map((member) => (
            <div key={member.name} className="group">
              <div className="aspect-square overflow-hidden border-2 border-black">
                <img
                  src={member.image || "/placeholder.svg"}
                  alt={member.name}
                  className="w-full h-full object-cover grayscale group-hover:grayscale-0 transition-all duration-500"
                />
              </div>
              <div className="mt-4">
                <h3 className="font-serif text-xl uppercase text-black">{member.name}</h3>
                <p className="font-mono text-xs text-black/70 uppercase">{member.role}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      <Footer />
    </main>
  )
}
