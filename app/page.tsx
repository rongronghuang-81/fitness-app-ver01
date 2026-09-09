import { redirect } from "next/navigation";
import { createClient } from "@/lib/supabase/server";

export default async function HomePage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // If user is authenticated, redirect to dashboard
  // If not, redirect to login (middleware will handle this)
  if (user) {
    redirect("/dashboard");
  } else {
    redirect("/login");
  }
}
