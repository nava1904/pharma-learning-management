import { useState } from "react";
import { useNavigate } from "react-router";
import {
  mockUsers,
  mockCourses,
  mockAssignments,
  mockComplianceMetrics,
} from "../data/mockData";
import {
  Users,
  BookOpen,
  TrendingUp,
  AlertTriangle,
  LogOut,
  Plus,
  Search,
  Filter,
  BarChart3,
} from "lucide-react";

export function AdminDashboard() {
  const navigate = useNavigate();
  const currentUser = mockUsers.find((u) => u.role === "admin");
  const [searchTerm, setSearchTerm] = useState("");
  const [selectedDepartment, setSelectedDepartment] = useState("all");

  const departments = [
    "Production",
    "Quality Assurance",
    "Warehouse",
    "Laboratory",
    "Engineering",
  ];

  const totalEmployees = 118; // Sum of all compliance metrics
  const overallCompliance = Math.round(
    mockComplianceMetrics.reduce(
      (sum, dept) => sum + dept.complianceRate,
      0
    ) / mockComplianceMetrics.length
  );
  const totalOverdue = mockComplianceMetrics.reduce(
    (sum, dept) => sum + dept.overdue,
    0
  );

  const handleAssignTraining = () => {
    // In real app, would open a modal
    alert(
      "Training Assignment: Select courses, employees/roles/departments, and set due dates."
    );
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <div className="bg-indigo-600 p-2 rounded-lg">
                <Users className="size-6 text-white" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  Training Administrator Portal
                </h1>
                <p className="text-sm text-slate-600">{currentUser?.name}</p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <button
                onClick={() => navigate("/qa/compliance-report")}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <BarChart3 className="size-4" />
                <span className="text-sm">Reports</span>
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

      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* Overall Stats */}
        <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Total Employees</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {totalEmployees}
                </p>
              </div>
              <div className="bg-blue-100 p-3 rounded-lg">
                <Users className="size-6 text-blue-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Active Courses</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {mockCourses.filter((c) => c.status === "approved").length}
                </p>
              </div>
              <div className="bg-green-100 p-3 rounded-lg">
                <BookOpen className="size-6 text-green-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Overall Compliance</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {overallCompliance}%
                </p>
              </div>
              <div className="bg-amber-100 p-3 rounded-lg">
                <TrendingUp className="size-6 text-amber-600" />
              </div>
            </div>
          </div>

          <div className="bg-white rounded-lg p-6 border border-slate-200">
            <div className="flex items-center justify-between">
              <div>
                <p className="text-sm text-slate-600">Overdue Training</p>
                <p className="text-2xl font-bold text-slate-900 mt-1">
                  {totalOverdue}
                </p>
              </div>
              <div className="bg-red-100 p-3 rounded-lg">
                <AlertTriangle className="size-6 text-red-600" />
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
              onClick={handleAssignTraining}
              className="flex items-center gap-3 p-4 border-2 border-indigo-200 bg-indigo-50 rounded-lg hover:bg-indigo-100 transition-colors"
            >
              <div className="bg-indigo-600 p-2 rounded-lg">
                <Plus className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">Assign Training</p>
                <p className="text-sm text-slate-600">
                  By role, department, or individual
                </p>
              </div>
            </button>

            <button
              onClick={() => navigate("/admin/course-builder")}
              className="flex items-center gap-3 p-4 border-2 border-green-200 bg-green-50 rounded-lg hover:bg-green-100 transition-colors"
            >
              <div className="bg-green-600 p-2 rounded-lg">
                <BookOpen className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">Create Course</p>
                <p className="text-sm text-slate-600">Build new training module</p>
              </div>
            </button>

            <button
              onClick={() => navigate("/qa/compliance-report")}
              className="flex items-center gap-3 p-4 border-2 border-amber-200 bg-amber-50 rounded-lg hover:bg-amber-100 transition-colors"
            >
              <div className="bg-amber-600 p-2 rounded-lg">
                <BarChart3 className="size-5 text-white" />
              </div>
              <div className="text-left">
                <p className="font-semibold text-slate-900">
                  Generate Report
                </p>
                <p className="text-sm text-slate-600">Export compliance data</p>
              </div>
            </button>
          </div>
        </div>

        {/* Compliance Heatmap */}
        <div className="bg-white rounded-lg border border-slate-200 mb-8">
          <div className="px-6 py-4 border-b border-slate-200">
            <h2 className="text-lg font-semibold text-slate-900">
              Department Compliance Heatmap
            </h2>
          </div>
          <div className="p-6">
            <div className="grid grid-cols-1 gap-4">
              {mockComplianceMetrics.map((dept) => (
                <div key={dept.department}>
                  <div className="flex items-center justify-between mb-2">
                    <div>
                      <span className="font-medium text-slate-900">
                        {dept.department}
                      </span>
                      <span className="text-sm text-slate-600 ml-3">
                        {dept.compliant} / {dept.totalEmployees} compliant
                      </span>
                    </div>
                    <div className="flex items-center gap-4">
                      {dept.overdue > 0 && (
                        <span className="text-sm text-red-600 font-medium">
                          {dept.overdue} overdue
                        </span>
                      )}
                      <span
                        className={`text-lg font-bold ${
                          dept.complianceRate >= 95
                            ? "text-green-600"
                            : dept.complianceRate >= 90
                            ? "text-yellow-600"
                            : "text-red-600"
                        }`}
                      >
                        {dept.complianceRate.toFixed(1)}%
                      </span>
                    </div>
                  </div>
                  <div className="h-3 bg-slate-200 rounded-full overflow-hidden">
                    <div
                      className={`h-full transition-all ${
                        dept.complianceRate >= 95
                          ? "bg-green-500"
                          : dept.complianceRate >= 90
                          ? "bg-yellow-500"
                          : "bg-red-500"
                      }`}
                      style={{ width: `${dept.complianceRate}%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Course Management */}
        <div className="bg-white rounded-lg border border-slate-200">
          <div className="px-6 py-4 border-b border-slate-200">
            <div className="flex items-center justify-between">
              <h2 className="text-lg font-semibold text-slate-900">
                Course Management
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

          {/* Search and Filter */}
          <div className="px-6 py-4 border-b border-slate-200 bg-slate-50">
            <div className="flex gap-4">
              <div className="flex-1 relative">
                <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 size-4 text-slate-400" />
                <input
                  type="text"
                  value={searchTerm}
                  onChange={(e) => setSearchTerm(e.target.value)}
                  placeholder="Search courses..."
                  className="w-full pl-10 pr-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
              <select
                value={selectedDepartment}
                onChange={(e) => setSelectedDepartment(e.target.value)}
                className="px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              >
                <option value="all">All Status</option>
                <option value="approved">Approved</option>
                <option value="pending-qa">Pending QA</option>
                <option value="draft">Draft</option>
              </select>
            </div>
          </div>

          {/* Course List */}
          <div className="divide-y divide-slate-200">
            {mockCourses.map((course) => (
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
                    <button
                      onClick={handleAssignTraining}
                      className="px-4 py-2 text-sm bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
                    >
                      Assign
                    </button>
                  </div>
                </div>
              </div>
            ))}
          </div>
        </div>
      </main>
    </div>
  );
}
