import { useNavigate } from "react-router";
import { mockUsers, mockCourses } from "../data/mockData";
import {
  GraduationCap,
  BookOpen,
  FileText,
  LogOut,
  Plus,
  CheckCircle2,
  Clock,
} from "lucide-react";

export function SMEDashboard() {
  const navigate = useNavigate();
  const currentUser = mockUsers.find((u) => u.role === "sme");

  const myCourses = mockCourses.filter((c) => c.createdBy === currentUser?.id);
  const draftCourses = myCourses.filter((c) => c.status === "draft").length;
  const pendingCourses = myCourses.filter(
    (c) => c.status === "pending-qa"
  ).length;
  const approvedCourses = myCourses.filter(
    (c) => c.status === "approved"
  ).length;

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="bg-indigo-600 p-2 rounded-lg">
                <GraduationCap className="size-6 text-white" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  Subject Matter Expert Portal
                </h1>
                <p className="text-sm text-slate-600">{currentUser?.name}</p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <button
                onClick={() => navigate("/")}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <LogOut className="size-4" />
                <span className="text-sm">Logout</span>
              </button>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Total Courses</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {myCourses.length}
                </p>
              </div>
              <div className="bg-blue-100 p-3 rounded-lg">
                <BookOpen className="size-6 text-blue-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Drafts</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {draftCourses}
                </p>
              </div>
              <div className="bg-slate-100 p-3 rounded-lg">
                <FileText className="size-6 text-slate-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Pending QA</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {pendingCourses}
                </p>
              </div>
              <div className="bg-yellow-100 p-3 rounded-lg">
                <Clock className="size-6 text-yellow-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Approved</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {approvedCourses}
                </p>
              </div>
              <div className="bg-green-100 p-3 rounded-lg">
                <CheckCircle2 className="size-6 text-green-600" />
              </div>
            </div>
          </div>
        </div>

        {/* Quick Actions */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-8">
          <h2 className="text-lg font-semibold text-slate-900 mb-4">
            Quick Actions
          </h2>
          <div className="grid grid-cols-1 md:grid-cols-3 gap-4">
            <button
              onClick={() => navigate("/admin/course-builder")}
              className="flex items-center gap-3 p-4 border-2 border-indigo-200 bg-indigo-50 rounded-lg hover:bg-indigo-100 transition-colors"
            >
              <div className="bg-indigo-600 p-2 rounded-lg">
                <Plus className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">Create New Course</p>
                <p className="text-sm text-slate-600">
                  Build training content
                </p>
              </div>
            </button>

            <button className="flex items-center gap-3 p-4 border-2 border-green-200 bg-green-50 rounded-lg hover:bg-green-100 transition-colors">
              <div className="bg-green-600 p-2 rounded-lg">
                <FileText className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">Upload Materials</p>
                <p className="text-sm text-slate-600">SOPs, videos, documents</p>
              </div>
            </button>

            <button className="flex items-center gap-3 p-4 border-2 border-amber-200 bg-amber-50 rounded-lg hover:bg-amber-100 transition-colors">
              <div className="bg-amber-600 p-2 rounded-lg">
                <BookOpen className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">
                  Create Assessment
                </p>
                <p className="text-sm text-slate-600">Build quiz questions</p>
              </div>
            </button>
          </div>
        </div>

        {/* My Courses */}
        <div className="bg-white rounded-lg border border-slate-200">
          <div className="px-6 py-4 border-b border-slate-200">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold text-slate-900">
                My Courses
              </h2>
              <button
                onClick={() => navigate("/admin/course-builder")}
                className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
              >
                <Plus className="size-4" />
                <span className="text-sm">New Course</span>
              </button>
            </div>
          </div>

          <div className="divide-y divide-slate-200">
            {myCourses.map((course) => (
              <div
                key={course.id}
                className="p-6 hover:bg-slate-50 transition-colors"
              >
                <div className="flex items-start justify-between">
                  <div className="flex-1">
                    <div className="flex items-center gap-3 mb-2">
                      <h3 className="font-semibold text-slate-900">
                        {course.title}
                      </h3>
                      <span
                        className={`px-2 py-1 rounded text-xs font-medium ${
                          course.status === "approved"
                            ? "bg-green-100 text-green-800"
                            : course.status === "pending-qa"
                            ? "bg-yellow-100 text-yellow-800"
                            : "bg-slate-100 text-slate-800"
                        }`}
                      >
                        {course.status.toUpperCase()}
                      </span>
                    </div>
                    <p className="text-sm text-slate-600 mb-3">
                      {course.description}
                    </p>
                    <div className="flex items-center gap-4 text-sm text-slate-500">
                      <span>
                        {course.sopNumber} v{course.version}
                      </span>
                      <span>•</span>
                      <span>
                        Created: {new Date(course.createdDate).toLocaleDateString()}
                      </span>
                      {course.approvedDate && (
                        <>
                          <span>•</span>
                          <span>
                            Approved:{" "}
                            {new Date(course.approvedDate).toLocaleDateString()}
                          </span>
                        </>
                      )}
                    </div>
                  </div>
                  <div className="flex items-center gap-2">
                    <button
                      onClick={() =>
                        navigate(`/admin/course-builder/${course.id}`)
                      }
                      className="px-4 py-2 text-sm border border-slate-300 text-slate-700 rounded-lg hover:bg-slate-100"
                    >
                      Edit
                    </button>
                    {course.status === "approved" && (
                      <button className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
                        Update Version
                      </button>
                    )}
                  </div>
                </div>
              </div>
            ))}

            {myCourses.length === 0 && (
              <div className="p-12 text-center">
                <BookOpen className="size-12 text-slate-400 mx-auto mb-4" />
                <h3 className="text-lg font-semibold text-slate-900 mb-2">
                  No Courses Yet
                </h3>
                <p className="text-slate-600 mb-4">
                  Start creating training content for your department.
                </p>
                <button
                  onClick={() => navigate("/admin/course-builder")}
                  className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
                >
                  Create Your First Course
                </button>
              </div>
            )}
          </div>
        </div>

        {/* Guidelines */}
        <div className="mt-8 bg-blue-50 border border-blue-200 rounded-lg p-6">
          <h3 className="font-semibold text-blue-900 mb-3">
            SME Content Creation Guidelines
          </h3>
          <ul className="space-y-2 text-sm text-blue-800">
            <li className="flex items-start gap-2">
              <CheckCircle2 className="size-4 text-blue-600 mt-0.5" />
              <span>
                Ensure all SOP content aligns with current approved procedures
              </span>
            </li>
            <li className="flex items-start gap-2">
              <CheckCircle2 className="size-4 text-blue-600 mt-0.5" />
              <span>
                Create assessments with randomized question pools to prevent
                answer-sharing
              </span>
            </li>
            <li className="flex items-start gap-2">
              <CheckCircle2 className="size-4 text-blue-600 mt-0.5" />
              <span>
                Set appropriate minimum reading times to ensure comprehension
              </span>
            </li>
            <li className="flex items-start gap-2">
              <CheckCircle2 className="size-4 text-blue-600 mt-0.5" />
              <span>
                All courses require QA approval before release to production
              </span>
            </li>
          </ul>
        </div>
      </main>
    </div>
  );
}
