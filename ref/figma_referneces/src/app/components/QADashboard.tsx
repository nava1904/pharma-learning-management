import { useState } from "react";
import { useNavigate } from "react-router";
import { mockUsers, mockCourses, mockComplianceMetrics } from "../data/mockData";
import {
  Shield,
  CheckCircle2,
  AlertTriangle,
  FileText,
  LogOut,
  Clock,
  TrendingUp,
  Users,
} from "lucide-react";

export function QADashboard() {
  const navigate = useNavigate();
  const currentUser = mockUsers.find((u) => u.role === "qa");
  const [selectedTab, setSelectedTab] = useState<
    "overview" | "approvals" | "compliance"
  >("overview");

  const pendingApprovals = mockCourses.filter(
    (c) => c.status === "pending-qa"
  ).length;

  const overallCompliance = Math.round(
    mockComplianceMetrics.reduce((sum, dept) => sum + dept.complianceRate, 0) /
      mockComplianceMetrics.length
  );

  const criticalDepartments = mockComplianceMetrics.filter(
    (d) => d.complianceRate < 95
  );

  const totalEmployees = mockComplianceMetrics.reduce(
    (sum, dept) => sum + dept.totalEmployees,
    0
  );

  const handleApprove = (courseId: string) => {
    alert(
      `Course approval flow:\n\n1. Review training content\n2. Select "Meaning of Signature"\n3. Re-authenticate with password\n4. Course released to production\n5. Audit trail updated`
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
                <Shield className="size-6 text-white" />
              </div>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  Quality Assurance Portal
                </h1>
                <p className="text-sm text-slate-600">{currentUser?.name}</p>
              </div>
            </div>

            <div className="flex items-center gap-4">
              <button
                onClick={() => navigate("/qa/audit-trail")}
                className="flex items-center gap-2 px-4 py-2 text-slate-700 hover:bg-slate-100 rounded-lg transition-colors"
              >
                <FileText className="size-4" />
                <span className="text-sm">Audit Trail</span>
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
        {/* Tabs */}
        <div className="flex gap-2 mb-8">
          <button
            onClick={() => setSelectedTab("overview")}
            className={`px-4 py-2 rounded-lg transition-colors ${
              selectedTab === "overview"
                ? "bg-indigo-600 text-white"
                : "bg-white text-slate-700 hover:bg-slate-100"
            }`}
          >
            Overview
          </button>
          <button
            onClick={() => setSelectedTab("approvals")}
            className={`px-4 py-2 rounded-lg transition-colors relative ${
              selectedTab === "approvals"
                ? "bg-indigo-600 text-white"
                : "bg-white text-slate-700 hover:bg-slate-100"
            }`}
          >
            Pending Approvals
            {pendingApprovals > 0 && (
              <span className="absolute -top-1 -right-1 bg-red-500 text-white text-xs rounded-full size-5 flex items-center justify-center">
                {pendingApprovals}
              </span>
            )}
          </button>
          <button
            onClick={() => setSelectedTab("compliance")}
            className={`px-4 py-2 rounded-lg transition-colors ${
              selectedTab === "compliance"
                ? "bg-indigo-600 text-white"
                : "bg-white text-slate-700 hover:bg-slate-100"
            }`}
          >
            Compliance Monitoring
          </button>
        </div>

        {/* Overview Tab */}
        {selectedTab === "overview" && (
          <>
            {/* Stats */}
            <div className="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
              <div className="bg-white rounded-lg p-6 border border-slate-200">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600">Overall Compliance</p>
                    <p className="text-2xl font-bold text-slate-900 mt-1">
                      {overallCompliance}%
                    </p>
                  </div>
                  <div className="bg-green-100 p-3 rounded-lg">
                    <TrendingUp className="size-6 text-green-600" />
                  </div>
                </div>
              </div>

              <div className="bg-white rounded-lg p-6 border border-slate-200">
                <div className="flex items-center justify-between">
                  <div>
                    <p className="text-sm text-slate-600">Pending Approvals</p>
                    <p className="text-2xl font-bold text-slate-900 mt-1">
                      {pendingApprovals}
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
                    <p className="text-sm text-slate-600">At-Risk Departments</p>
                    <p className="text-2xl font-bold text-slate-900 mt-1">
                      {criticalDepartments.length}
                    </p>
                  </div>
                  <div className="bg-red-100 p-3 rounded-lg">
                    <AlertTriangle className="size-6 text-red-600" />
                  </div>
                </div>
              </div>

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
            </div>

            {/* Compliance Alerts */}
            {criticalDepartments.length > 0 && (
              <div className="bg-red-50 border border-red-200 rounded-lg p-6 mb-8">
                <div className="flex items-start gap-3 mb-4">
                  <AlertTriangle className="size-5 text-red-600 mt-0.5" />
                  <div>
                    <h3 className="font-semibold text-red-900 mb-1">
                      Compliance Drop Alert
                    </h3>
                    <p className="text-sm text-red-700">
                      {criticalDepartments.length} department(s) have fallen below
                      the 95% compliance threshold. Immediate action required.
                    </p>
                  </div>
                </div>
                <div className="space-y-2">
                  {criticalDepartments.map((dept) => (
                    <div
                      key={dept.department}
                      className="flex items-center justify-between bg-white rounded p-3"
                    >
                      <div>
                        <span className="font-medium text-slate-900">
                          {dept.department}
                        </span>
                        <span className="text-sm text-slate-600 ml-3">
                          {dept.overdue} employees overdue
                        </span>
                      </div>
                      <span className="text-red-600 font-bold">
                        {dept.complianceRate.toFixed(1)}%
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            )}

            {/* Recent Activities */}
            <div className="bg-white rounded-lg border border-slate-200">
              <div className="px-6 py-4 border-b border-slate-200">
                <h2 className="text-lg font-semibold text-slate-900">
                  Recent QA Activities
                </h2>
              </div>
              <div className="divide-y divide-slate-200">
                <div className="p-6">
                  <div className="flex items-start gap-3">
                    <CheckCircle2 className="size-5 text-green-600 mt-0.5" />
                    <div className="flex-1">
                      <p className="font-medium text-slate-900">
                        Course Approved: Data Integrity Training
                      </p>
                      <p className="text-sm text-slate-600">
                        Approved and released to production
                      </p>
                      <p className="text-xs text-slate-500 mt-1">
                        March 5, 2026 at 4:00 PM
                      </p>
                    </div>
                  </div>
                </div>
                <div className="p-6">
                  <div className="flex items-start gap-3">
                    <CheckCircle2 className="size-5 text-green-600 mt-0.5" />
                    <div className="flex-1">
                      <p className="font-medium text-slate-900">
                        Course Approved: Sterile Filling SOP v3.0
                      </p>
                      <p className="text-sm text-slate-600">
                        SOP update approved, retraining workflow initiated
                      </p>
                      <p className="text-xs text-slate-500 mt-1">
                        February 20, 2026 at 2:30 PM
                      </p>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </>
        )}

        {/* Approvals Tab */}
        {selectedTab === "approvals" && (
          <div className="bg-white rounded-lg border border-slate-200">
            <div className="px-6 py-4 border-b border-slate-200">
              <h2 className="text-lg font-semibold text-slate-900">
                Courses Pending QA Approval
              </h2>
            </div>
            {pendingApprovals === 0 ? (
              <div className="p-12 text-center">
                <CheckCircle2 className="size-12 text-green-500 mx-auto mb-4" />
                <h3 className="text-lg font-semibold text-slate-900 mb-2">
                  All Caught Up!
                </h3>
                <p className="text-slate-600">
                  There are no courses pending approval at this time.
                </p>
              </div>
            ) : (
              <div className="divide-y divide-slate-200">
                {mockCourses
                  .filter((c) => c.status === "pending-qa")
                  .map((course) => (
                    <div key={course.id} className="p-6">
                      <div className="flex items-start justify-between">
                        <div className="flex-1">
                          <div className="flex items-center gap-3 mb-2">
                            <h3 className="font-semibold text-slate-900">
                              {course.title}
                            </h3>
                            <span className="px-2 py-1 bg-yellow-100 text-yellow-800 rounded text-xs font-medium">
                              PENDING APPROVAL
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
                              Created:{" "}
                              {new Date(course.createdDate).toLocaleDateString()}
                            </span>
                            <span>•</span>
                            <span>
                              By:{" "}
                              {
                                mockUsers.find((u) => u.id === course.createdBy)
                                  ?.name
                              }
                            </span>
                          </div>
                        </div>
                        <div className="flex items-center gap-2">
                          <button className="px-4 py-2 text-sm border border-slate-300 text-slate-700 rounded-lg hover:bg-slate-100">
                            Review
                          </button>
                          <button
                            onClick={() => handleApprove(course.id)}
                            className="px-4 py-2 text-sm bg-green-600 text-white rounded-lg hover:bg-green-700"
                          >
                            Approve
                          </button>
                        </div>
                      </div>
                    </div>
                  ))}
              </div>
            )}
          </div>
        )}

        {/* Compliance Tab */}
        {selectedTab === "compliance" && (
          <>
            <div className="flex items-center justify-between mb-6">
              <div>
                <h2 className="text-lg font-semibold text-slate-900">
                  Department Compliance Monitoring
                </h2>
                <p className="text-sm text-slate-600">
                  Real-time compliance tracking across all departments
                </p>
              </div>
              <button
                onClick={() => navigate("/qa/compliance-report")}
                className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
              >
                Export Report
              </button>
            </div>

            <div className="bg-white rounded-lg border border-slate-200 p-6">
              <div className="space-y-6">
                {mockComplianceMetrics.map((dept) => (
                  <div
                    key={dept.department}
                    className={`p-4 rounded-lg border-2 ${
                      dept.complianceRate < 95
                        ? "border-red-300 bg-red-50"
                        : "border-green-200 bg-green-50"
                    }`}
                  >
                    <div className="flex items-center justify-between mb-3">
                      <div>
                        <h3 className="font-semibold text-slate-900">
                          {dept.department}
                        </h3>
                        <p className="text-sm text-slate-600">
                          {dept.totalEmployees} employees
                        </p>
                      </div>
                      <div className="text-right">
                        <div
                          className={`text-2xl font-bold ${
                            dept.complianceRate >= 95
                              ? "text-green-600"
                              : "text-red-600"
                          }`}
                        >
                          {dept.complianceRate.toFixed(1)}%
                        </div>
                        <p className="text-sm text-slate-600">compliance</p>
                      </div>
                    </div>

                    <div className="grid grid-cols-3 gap-4 mb-3">
                      <div className="text-center">
                        <div className="text-lg font-bold text-green-600">
                          {dept.compliant}
                        </div>
                        <div className="text-xs text-slate-600">Compliant</div>
                      </div>
                      <div className="text-center">
                        <div className="text-lg font-bold text-red-600">
                          {dept.overdue}
                        </div>
                        <div className="text-xs text-slate-600">Overdue</div>
                      </div>
                      <div className="text-center">
                        <div className="text-lg font-bold text-yellow-600">
                          {dept.upcoming}
                        </div>
                        <div className="text-xs text-slate-600">Upcoming</div>
                      </div>
                    </div>

                    <div className="h-2 bg-slate-200 rounded-full overflow-hidden">
                      <div
                        className={`h-full transition-all ${
                          dept.complianceRate >= 95
                            ? "bg-green-500"
                            : "bg-red-500"
                        }`}
                        style={{ width: `${dept.complianceRate}%` }}
                      />
                    </div>
                  </div>
                ))}
              </div>
            </div>
          </>
        )}
      </main>
    </div>
  );
}
