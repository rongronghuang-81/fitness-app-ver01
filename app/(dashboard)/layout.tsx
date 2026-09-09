import { createClient } from "@/lib/supabase/server";
import { redirect } from "next/navigation";
import Link from "next/link";
import { Button } from "@/components/ui/button";

export default async function DashboardLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  if (!user) {
    redirect("/login");
  }

  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user.id)
    .single();

  const handleSignOut = async () => {
    "use server";
    const supabase = await createClient();
    await supabase.auth.signOut();
    redirect("/login");
  };

  return (
    <div className="min-h-screen bg-zinc-50">
      {/* Top Navigation */}
      <nav className="bg-white border-b border-zinc-200">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
          <div className="flex justify-between items-center h-16">
            <div className="flex items-center gap-8">
              <Link href="/dashboard" className="text-xl font-bold text-zinc-900">
                Pole Fitness
              </Link>

              {/* Desktop Navigation */}
              <div className="hidden md:flex items-center gap-6">
                <Link href="/dashboard" className="text-sm font-medium text-zinc-700 hover:text-zinc-900">
                  Dashboard
                </Link>
                <Link href="/students" className="text-sm font-medium text-zinc-700 hover:text-zinc-900">
                  Students
                </Link>
                <Link href="/terms" className="text-sm font-medium text-zinc-700 hover:text-zinc-900">
                  Terms
                </Link>
                <Link href="/classes" className="text-sm font-medium text-zinc-700 hover:text-zinc-900">
                  Classes
                </Link>
                <Link href="/settings" className="text-sm font-medium text-zinc-700 hover:text-zinc-900">
                  Settings
                </Link>
              </div>
            </div>

            {/* User Menu */}
            <div className="flex items-center gap-4">
              <span className="text-sm text-zinc-700">
                {profile?.first_name || user.email}
              </span>
              <form action={handleSignOut}>
                <Button type="submit" variant="outline" size="sm">
                  Sign Out
                </Button>
              </form>
            </div>
          </div>
        </div>
      </nav>

      {/* Mobile Navigation */}
      <div className="md:hidden fixed bottom-0 left-0 right-0 bg-white border-t border-zinc-200 z-50">
        <div className="grid grid-cols-5 gap-1 p-2">
          <Link href="/dashboard" className="flex flex-col items-center gap-1 py-2 text-xs text-zinc-700">
            <span className="text-lg">🏠</span>
            <span>Home</span>
          </Link>
          <Link href="/students" className="flex flex-col items-center gap-1 py-2 text-xs text-zinc-700">
            <span className="text-lg">👥</span>
            <span>Students</span>
          </Link>
          <Link href="/terms" className="flex flex-col items-center gap-1 py-2 text-xs text-zinc-700">
            <span className="text-lg">📅</span>
            <span>Terms</span>
          </Link>
          <Link href="/classes" className="flex flex-col items-center gap-1 py-2 text-xs text-zinc-700">
            <span className="text-lg">📝</span>
            <span>Classes</span>
          </Link>
          <Link href="/settings" className="flex flex-col items-center gap-1 py-2 text-xs text-zinc-700">
            <span className="text-lg">⚙️</span>
            <span>More</span>
          </Link>
        </div>
      </div>

      {/* Main Content */}
      <main className="pb-20 md:pb-0">
        {children}
      </main>
    </div>
  );
}
