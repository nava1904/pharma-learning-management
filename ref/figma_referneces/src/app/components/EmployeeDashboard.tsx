import { useState } from "react";
import { useNavigate } from "react-router";
import {
  mockAssignments,
  mockCourses,
  mockCertifications,
  mockUsers,
} from "../data/mockData";
import {
  BookOpen,
  Clock,
  AlertTriangle,
  CheckCircle2,
  Award,
  LogOut,
  Bell,
  Calendar,
  TrendingUp,
} from "lucide-react";

export function EmployeeDashboard() {
  const navigate = useNavigate();
  const currentUser = mockUsers[0]; // Anil Kumar
  const [showNotifications, setShowNotifications] = useState(false);

  const userAssignments = mockAssignments.filter(
    (a) => a.userId === currentUser.id
  );

  const completedCount = userAssignments.filter(
    (a) => a.status === "completed"
  ).length;
  const totalCount = userAssignments.length;
  const compliancePercentage = Math.round((completedCount / totalCount) * 100);

  const upcomingDeadlines = userAssignments.filter(
    (a) => a.status !== "completed"
  );

  const userCertifications = mockCertifications.filter(
    (c) => c.userId === currentUser.id
  );

  const getCourse = (courseId: string) =>
    mockCourses.find((c) => c.id === courseId);

  const getStatusColor = (status: string) => {
    switch (status) {
      case "completed":
        return "bg-green-100 text-green-800";
      case "in-progress":
        return "bg-blue-100 text-blue-800";
      case "overdue":
        return "bg-red-100 text-red-800";
      default:
        return "bg-yellow-100 text-yellow-800";
    }
  };

  const getPriorityColor = (priority: string) => {
    switch (priority) {
      case "high":
        return "text-red-600";
      case "medium":
        return "text-yellow-600";
      default:
        return "text-slate-600";
    }
  };

  const getDaysUntilDue = (dueDate: string) => {
    const due = new Date(dueDate);
    const now = new Date();
    const diff = Math.ceil((due.getTime() - now.getTime()) / (1000 * 60 * 60 * 24));
    return diff;
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="bg-indigo-600 p-2 rounded-lg">
                <BookOpen className="size-6 text-white" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  Employee Portal
                </h1>
                <p className="text-sm text-slate-600">{currentUser.name}</p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <button
                onClick={() => setShowNotifications(!showNotifications)}
                className="relative p-2 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <Bell className="size-5 text-slate-600" />
                <span className="absolute top-1 right-1 bg-red-500 text-white text-xs rounded-full size-4 flex items-center justify-center">
                  2
                </span>
              </button>
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

      {/* Notifications Dropdown */}
      {showNotifications && (
        <div className="absolute top-20 right-6 w-96 bg-white rounded-lg shadow-xl border border-slate-200 z-50">
          <div className="p-4 border-b border-slate-200">
            <h3 className="font-semibold text-slate-900">Notifications</h3>
          </div>
          <div className="divide-y divide-slate-200">
            <div className="p-4 hover:bg-slate-50">
              <div className="flex items-start gap-3">
                <AlertTriangle className="size-5 text-red-500 mt-1" />
                <div>
                  <p className="text-sm font-medium text-slate-900">
                    Retraining Required
                  </p>
                  <p className="text-sm text-slate-600">
                    SOP-105 Sterile Filling has been updated to v3.0. Complete
                    retraining by March 21.
                  </p>
                  <p className="text-xs text-slate-500 mt-1">2 days ago</p>
                </div>
              </div>
            </div>
            <div className="p-4 hover:bg-slate-50">
              <div className="flex items-start gap-3">
                <Calendar className="size-5 text-blue-500 mt-1" />
                <div>
                  <p className="text-sm font-medium text-slate-900">
                    New Training Assigned
                  </p>
                  <p className="text-sm text-slate-600">
                    Data Integrity Training has been assigned. Due: March 20.
                  </p>
                  <p className="text-xs text-slate-500 mt-1">Today</p>
                </div>
              </div>
            </div>
          </div>
        </div>
      )}

      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* Compliance Widget */}
        <div className="bg-gradient-to-br from-indigo-600 to-indigo-800 rounded-xl p-6 text-white mb-8">
          <div className="flex items-center justify-between">
            <div>
              <h2 className="text-lg font-semibold mb-1">
                Compliance Health
              </h2>
              <p className="text-indigo-200 text-sm">
                {currentUser.department} - {currentUser.jobRole}
              </p>
            </div>
            <div className="text-right">
              <div className="text-4xl font-bold">{compliancePercentage}%</div>
              <p className="text-indigo-200 text-sm">
                {completedCount} of {totalCount} completed
              </p>
            </div>
          </div>
          <div className="mt-4 h-3 bg-indigo-900 rounded-full overflow-hidden">
            <div
              className="h-full bg-white transition-all"
              style={{ width: `${compliancePercentage}%` }}
            />
          </div>
        </div>

        {/* Quick Stats */}
        <div className="grid grid-cols-1 md:grid-cols-3 gap-6 mb-8">
          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Active Training</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {
                    userAssignments.filter((a) => a.status === "in-progress")
                      .length
                  }
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
                <p className="text-sm text-slate-600">Completed</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {completedCount}
                </p>
              </div>
              <div className="bg-green-100 p-3 rounded-lg">
                <CheckCircle2 className="size-6 text-green-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Certifications</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {userCertifications.length}
                </p>
              </div>
              <div className="bg-amber-100 p-3 rounded-lg">
                <Award className="size-6 text-amber-600" />
              </div>
            </div>
          </div>
        </div>

        {/* Training Alert */}
        {upcomingDeadlines.some((a) => getDaysUntilDue(a.dueDate) <= 7) && (
          <div className="bg-red-50 border border-red-200 rounded-lg p-4 mb-8">
            <div className="flex items-start gap-3">
              <AlertTriangle className="size-5 text-red-600 mt-0.5" />
              <div>
                <h3 className="font-semibold text-red-900">
                  Urgent Training Required
                </h3>
                <p className="text-sm text-red-700 mt-1">
                  You have training due within the next 7 days. Complete them to
                  maintain your compliance status.
                </p>
              </div>
            </div>
          </div>
        )}

        {/* Assigned Training */}
        <div className="bg-white rounded-lg border border-slate-200 mb-8">
          <div className="px-6 py-4 border-b border-slate-200">
            <h2 className="text-lg font-semibold text-slate-900">
              My Training Assignments
            </h2>
          </div>
          <div className="divide-y divide-slate-200">
            {userAssignments.map((assignment) => {
              const course = getCourse(assignment.courseId);
              if (!course) return null;

              const daysUntilDue = getDaysUntilDue(assignment.dueDate);

              return (
                <div
                  key={assignment.id}
                  className="p-6 hover:bg-slate-50 transition-colors"
                >
                  <div className="flex items-start justify-between gap-4">
                    <div className="flex-1">
                      <div className="flex items-center gap-3 mb-2">
                        <h3 className="font-semibold text-slate-900">
                          {course.title}
                        </h3>
                        <span
                          className={`px-2 py-1 rounded text-xs font-medium ${getStatusColor(
                            assignment.status
                          )}`}
                        >
                          {assignment.status.replace("-", " ").toUpperCase()}
                        </span>
                        {assignment.priority === "high" && (
                          <AlertTriangle
                            className={`size-4 ${getPriorityColor(
                              assignment.priority
                            )}`}
                          />
                        )}
                      </div>
                      <p className="text-sm text-slate-600 mb-3">
                        {course.description}
                      </p>
                      <div className="flex items-center gap-4 text-sm text-slate-500">
                        <span className="flex items-center gap-1">
                          <BookOpen className="size-4" />
                          {course.sopNumber} v{course.version}
                        </span>
                        <span className="flex items-center gap-1">
                          <Clock className="size-4" />
                          Due:{" "}
                          {new Date(assignment.dueDate).toLocaleDateString()}
                          {assignment.status !== "completed" &&
                            ` (${daysUntilDue} days)`}
                        </span>
                        {assignment.score && (
                          <span className="flex items-center gap-1">
                            <TrendingUp className="size-4" />
                            Score: {assignment.score}%
                          </span>
                        )}
                      </div>
                    </div>
                    <div className="flex items-center gap-2">
                      {assignment.status === "completed" ? (
                        <>
                          <button
                            onClick={() =>
                              navigate(
                                `/certificate/${assignment.certificationId}`
                              )
                            }
                            className="px-4 py-2 text-sm bg-green-100 text-green-700 rounded-lg hover:bg-green-200 transition-colors"
                          >
                            View Certificate
                          </button>
                        </>
                      ) : (
                        <button
                          onClick={() => navigate(`/course/${course.id}`)}
                          className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
                        >
                          {assignment.status === "in-progress"
                            ? "Continue"
                            : "Start Training"}
                        </button>
                      )}
                    </div>
                  </div>
                </div>
              );
            })}
          </div>
        </div>

        {/* My Certifications */}
        <div className="bg-white rounded-lg border border-slate-200">
          <div className="px-6 py-4 border-b border-slate-200">
            <h2 className="text-lg font-semibold text-slate-900">
              My Certifications
            </h2>
          </div>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4 p-6">
            {userCertifications.map((cert) => {
              const course = getCourse(cert.courseId);
              if (!course) return null;

              const daysUntilExpiry = cert.expiryDate
                ? getDaysUntilDue(cert.expiryDate)
                : null;
              const isExpiringSoon =
                daysUntilExpiry !== null && daysUntilExpiry <= 30;

              return (
                <div
                  key={cert.id}
                  className={`border rounded-lg p-4 ${
                    isExpiringSoon
                      ? "border-yellow-300 bg-yellow-50"
                      : "border-slate-200"
                  }`}
                >
                  <div className="flex items-start gap-3">
                    <Award className="size-6 text-amber-500" />
                    <div className="flex-1">
                      <h3 className="font-semibold text-slate-900">
                        {course.title}
                      </h3>
                      <p className="text-sm text-slate-600 mt-1">
                        Score: {cert.score}%
                      </p>
                      <p className="text-xs text-slate-500 mt-1">
                        Issued: {new Date(cert.issuedDate).toLocaleDateString()}
                      </p>
                      {cert.expiryDate && (
                        <p
                          className={`text-xs mt-1 ${
                            isExpiringSoon
                              ? "text-yellow-700 font-medium"
                              : "text-slate-500"
                          }`}
                        >
                          Expires:{" "}
                          {new Date(cert.expiryDate).toLocaleDateString()}
                          {isExpiringSoon && ` (${daysUntilExpiry} days)`}
                        </p>
                      )}
                    </div>
                    <button
                      onClick={() => navigate(`/certificate/${cert.id}`)}
                      className="text-sm text-indigo-600 hover:text-indigo-700"
                    >
                      View
                    </button>
                  </div>
                </div>
              );
            })}
          </div>
        </div>
      </main>
    </div>
  );
}
