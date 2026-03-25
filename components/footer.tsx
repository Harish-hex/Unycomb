"use client"

export function Footer() {
  return (
    <footer className="bg-[#FFA500] pt-20 pb-10">
      <div className="container mx-auto px-4">
        <div className="flex flex-col items-center text-center">
          <h2 className="font-serif text-[10vw] leading-none font-black uppercase mb-8 text-black">{"Have a Suggestion?"}</h2>
          <button className="px-12 py-4 bg-black text-white rounded-full font-mono text-xl uppercase hover:scale-105 transition-transform">
            Drop a Suggestion
          </button>
        </div>

        <div className="flex flex-col md:flex-row justify-between items-end mt-20 border-t-2 border-black pt-8 gap-4">
          <div className="font-mono font-bold uppercase text-sm text-black">© 2026 Unycomb. Students building</div>
          <div className="flex gap-8">
            {["Instagram", "Twitter", "LinkedIn", "Discord"].map((link) => (
              <a
                key={link}
                href="#"
                className="font-mono font-bold uppercase text-sm hover:underline decoration-2 text-black"
              >
                {link}
              </a>
            ))}
          </div>
        </div>
      </div>
    </footer>
  )
}
