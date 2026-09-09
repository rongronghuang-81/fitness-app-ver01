import { createClient } from "@/lib/supabase/server";
import { Card, CardContent, CardDescription, CardHeader, CardTitle } from "@/components/ui/card";
import { Button } from "@/components/ui/button";

export default async function DashboardPage() {
  const supabase = await createClient();
  const { data: { user } } = await supabase.auth.getUser();

  // Fetch instructor profile
  const { data: profile } = await supabase
    .from("profiles")
    .select("*")
    .eq("id", user?.id)
    .single();

  // Fetch basic stats
  const { count: studentsCount } = await supabase
    .from("students")
    .select("*", { count: "exact", head: true })
    .eq("instructor_id", user?.id)
    .eq("active", true);

  const { count: termsCount } = await supabase
    .from("terms")
    .select("*", { count: "exact", head: true })
    .eq("instructor_id", user?.id)
    .eq("status", "active");

  const { data: upcomingClasses } = await supabase
    .from("classes")
    .select("*, terms(name)")
    .eq("instructor_id", user?.id)
    .gte("scheduled_date", new Date().toISOString().split("T")[0])
    .order("scheduled_date", { ascending: true })
    .limit(5);

  return (
    <div className="p-6 max-w-7xl mx-auto">
      <div className="mb-8">
        <h1 className="text-3xl font-bold text-zinc-900">
          Welcome back{profile?.first_name ? `, ${profile.first_name}` : ""}!
        </h1>
        <p className="text-zinc-600 mt-2">
          Here's what's happening with your pole fitness classes
        </p>
      </div>

      {/* Stats Grid */}
      <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
        <Card>
          <CardHeader>
            <CardDescription>Active Students</CardDescription>
            <CardTitle className="text-4xl">{studentsCount || 0}</CardTitle>
          </CardHeader>
        </Card>

        <Card>
          <CardHeader>
            <CardDescription>Active Terms</CardDescription>
            <CardTitle className="text-4xl">{termsCount || 0}</CardTitle>
          </CardHeader>
        </Card>

        <Card>
          <CardHeader>
            <CardDescription>Upcoming Classes</CardDescription>
            <CardTitle className="text-4xl">{upcomingClasses?.length || 0}</CardTitle>
          </CardHeader>
        </Card>
      </div>

      {/* Upcoming Classes */}
      <Card className="mb-8">
        <CardHeader>
          <CardTitle>Upcoming Classes</CardTitle>
          <CardDescription>Your next scheduled classes</CardDescription>
        </CardHeader>
        <CardContent>
          {upcomingClasses && upcomingClasses.length > 0 ? (
            <div className="space-y-4">
              {upcomingClasses.map((classItem: any) => (
                <div
                  key={classItem.id}
                  className="flex items-center justify-between p-4 border border-zinc-200 rounded-lg hover:bg-zinc-50 transition-colors"
                >
                  <div>
                    <p className="font-medium text-zinc-900">
                      {classItem.terms?.name || "Unnamed Term"} - Week {classItem.week_number}
                    </p>
                    <p className="text-sm text-zinc-600">
                      {new Date(classItem.scheduled_date).toLocaleDateString("en-SG", {
                        weekday: "long",
                        year: "numeric",
                        month: "long",
                        day: "numeric",
                      })}{" "}
                      at {classItem.start_time}
                    </p>
                  </div>
                  <Button variant="outline" size="sm">
                    View
                  </Button>
                </div>
              ))}
            </div>
          ) : (
            <div className="text-center py-12">
              <p className="text-zinc-600 mb-4">No upcoming classes scheduled</p>
              <Button variant="outline">Create a Term</Button>
            </div>
          )}
        </CardContent>
      </Card>

      {/* Quick Actions */}
      <Card>
        <CardHeader>
          <CardTitle>Quick Actions</CardTitle>
          <CardDescription>Get started with common tasks</CardDescription>
        </CardHeader>
        <CardContent>
          <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-4">
            <Button className="h-auto py-6 flex-col gap-2" variant="outline">
              <span className="text-2xl">👤</span>
              <span>Add Student</span>
            </Button>
            <Button className="h-auto py-6 flex-col gap-2" variant="outline">
              <span className="text-2xl">📅</span>
              <span>Create Term</span>
            </Button>
            <Button className="h-auto py-6 flex-col gap-2" variant="outline">
              <span className="text-2xl">📝</span>
              <span>Plan Lesson</span>
            </Button>
            <Button className="h-auto py-6 flex-col gap-2" variant="outline">
              <span className="text-2xl">⚙️</span>
              <span>Settings</span>
            </Button>
          </div>
        </CardContent>
      </Card>
    </div>
  );
}
