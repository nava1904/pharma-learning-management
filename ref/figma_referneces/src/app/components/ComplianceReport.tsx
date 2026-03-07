import { useNavigate } from "react-router";
import { mockComplianceMetrics, mockCourses } from "../data/mockData";
import {
  ArrowLeft,
  Download,
  TrendingUp,
  AlertTriangle,
  CheckCircle2,
  Calendar,
} from "lucide-react";

export function ComplianceReport() {
  const navigate = useNavigate();

  const totalEmployees = mockComplianceMetrics.reduce(
    (sum, dept) => sum + dept.totalEmployees,
    0
  );
  const totalCompliant = mockComplianceMetrics.reduce(
    (sum, dept) => sum + dept.compliant,
    0
  );
  const totalOverdue = mockComplianceMetrics.reduce(
    (sum, dept) => sum + dept.overdue,
    0
  );
  const overallCompliance = Math.round(
    (totalCompliant / totalEmployees) * 100
  );

  const currentDate = new Date().toLocaleDateString("en-US", {
    year: "numeric",
    month: "long",
    day: "numeric",
  });

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200">
        <div className="max-w-7xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <button
                onClick={() => navigate("/qa")}
                className="p-2 hover:bg-slate-100 rounded-lg"
              >
                <ArrowLeft className="size-5" />
              </button>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  Compliance Report
                </h1>
                <p className="text-sm text-slate-600">
                  Generated on {currentDate}
                </p>
              </div>
            </div>

            <button className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
              <Download className="size-4" />
              <span className="text-sm">Export PDF</span>
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* Report Header */}
        <div className="bg-white rounded-lg border border-slate-200 p-8 mb-8">
          <div className="flex items-center justify-between mb-6">
            <div>
              <h2 className="text-2xl font-bold text-slate-900 mb-2">
                Training Compliance Report
              </h2>
              <p className="text-slate-600">
                Comprehensive overview of training compliance across all
                departments
              </p>
            </div>
            <div className="text-right">
              <div className="text-sm text-slate-600">Report Date</div>
              <div className="font-semibold text-slate-900">{currentDate}</div>
            </div>
          </div>

          <div className="grid grid-cols-4 gap-6">
            <div className="border-l-4 border-blue-500 pl-4">
              <div className="text-sm text-slate-600">Total Employees</div>
              <div className="text-3xl font-bold text-slate-900">
                {totalEmployees}
              </div>
            </div>
            <div className="border-l-4 border-green-500 pl-4">
              <div className="text-sm text-slate-600">Compliant</div>
              <div className="text-3xl font-bold text-green-600">
                {totalCompliant}
              </div>
            </div>
            <div className="border-l-4 border-red-500 pl-4">
              <div className="text-sm text-slate-600">Overdue</div>
              <div className="text-3xl font-bold text-red-600">
                {totalOverdue}
              </div>
            </div>
            <div className="border-l-4 border-amber-500 pl-4">
              <div className="text-sm text-slate-600">Compliance Rate</div>
              <div className="text-3xl font-bold text-amber-600">
                {overallCompliance}%
              </div>
            </div>
          </div>
        </div>

        {/* Executive Summary */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-8">
          <h3 className="text-lg font-semibold text-slate-900 mb-4">
            Executive Summary
          </h3>
          <div className="space-y-3 text-slate-700">
            <p>
              As of {currentDate}, the organization maintains an overall
              training compliance rate of <strong>{overallCompliance}%</strong>{" "}
              across all departments.
            </p>
            <p>
              <strong>{totalCompliant}</strong> out of{" "}
              <strong>{totalEmployees}</strong> employees are currently
              compliant with their assigned training requirements.
            </p>
            <p>
              <strong className="text-red-600">{totalOverdue}</strong> employees
              have overdue training that requires immediate attention to maintain
              regulatory compliance.
            </p>
            {overallCompliance < 95 && (
              <div className="bg-red-50 border border-red-200 rounded-lg p-4 mt-4">
                <div className="flex items-start gap-2">
                  <AlertTriangle className="size-5 text-red-600 mt-0.5" />
                  <p className="text-sm text-red-900">
                    <strong>Action Required:</strong> Overall compliance has
                    fallen below the 95% threshold. Immediate corrective actions
                    are recommended to restore compliance before the next audit.
                  </p>
                </div>
              </div>
            )}
          </div>
        </div>

        {/* Department Breakdown */}
        <div className="bg-white rounded-lg border border-slate-200 mb-8">
          <div className="px-6 py-4 border-b border-slate-200">
            <h3 className="text-lg font-semibold text-slate-900">
              Department Breakdown
            </h3>
          </div>
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-slate-50">
                <tr>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Department
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Total
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Compliant
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Overdue
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Upcoming
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Compliance %
                  </th>
                  <th className="px-6 py-3 text-left text-xs font-medium text-slate-700 uppercase tracking-wider">
                    Status
                  </th>
                </tr>
              </thead>
              <tbody className="divide-y divide-slate-200">
                {mockComplianceMetrics.map((dept) => (
                  <tr key={dept.department} className="hover:bg-slate-50">
                    <td className="px-6 py-4 whitespace-nowrap font-medium text-slate-900">
                      {dept.department}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap text-slate-700">
                      {dept.totalEmployees}
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-green-600 font-medium">
                        {dept.compliant}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-red-600 font-medium">
                        {dept.overdue}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span className="text-yellow-600 font-medium">
                        {dept.upcoming}
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      <span
                        className={`font-bold ${
                          dept.complianceRate >= 95
                            ? "text-green-600"
                            : dept.complianceRate >= 90
                            ? "text-yellow-600"
                            : "text-red-600"
                        }`}
                      >
                        {dept.complianceRate.toFixed(1)}%
                      </span>
                    </td>
                    <td className="px-6 py-4 whitespace-nowrap">
                      {dept.complianceRate >= 95 ? (
                        <span className="flex items-center gap-1 text-green-600">
                          <CheckCircle2 className="size-4" />
                          <span className="text-sm">Compliant</span>
                        </span>
                      ) : (
                        <span className="flex items-center gap-1 text-red-600">
                          <AlertTriangle className="size-4" />
                          <span className="text-sm">At Risk</span>
                        </span>
                      )}
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {/* Course Statistics */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-8">
          <h3 className="text-lg font-semibold text-slate-900 mb-4">
            Active Training Courses
          </h3>
          <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
            {mockCourses
              .filter((c) => c.status === "approved")
              .map((course) => (
                <div
                  key={course.id}
                  className="border border-slate-200 rounded-lg p-4"
                >
                  <div className="flex items-start justify-between mb-2">
                    <h4 className="font-semibold text-slate-900">
                      {course.title}
                    </h4>
                    <span className="px-2 py-1 bg-green-100 text-green-800 rounded text-xs font-medium">
                      Active
                    </span>
                  </div>
                  <p className="text-sm text-slate-600 mb-2">
                    {course.description}
                  </p>
                  <div className="flex items-center gap-4 text-xs text-slate-500">
                    <span>
                      {course.sopNumber} v{course.version}
                    </span>
                    {course.expiryMonths && (
                      <>
                        <span>•</span>
                        <span>Valid: {course.expiryMonths} months</span>
                      </>
                    )}
                  </div>
                </div>
              ))}
          </div>
        </div>

        {/* Recommendations */}
        <div className="bg-white rounded-lg border border-slate-200 p-6">
          <h3 className="text-lg font-semibold text-slate-900 mb-4">
            Recommendations
          </h3>
          <div className="space-y-3">
            {totalOverdue > 0 && (
              <div className="flex items-start gap-3 p-4 bg-red-50 border border-red-200 rounded-lg">
                <AlertTriangle className="size-5 text-red-600 mt-0.5" />
                <div>
                  <p className="font-medium text-red-900">
                    Address Overdue Training
                  </p>
                  <p className="text-sm text-red-700">
                    {totalOverdue} employees have overdue training. Send
                    immediate notifications and escalate to management if not
                    completed within 48 hours.
                  </p>
                </div>
              </div>
            )}

            {overallCompliance < 95 && (
              <div className="flex items-start gap-3 p-4 bg-yellow-50 border border-yellow-200 rounded-lg">
                <TrendingUp className="size-5 text-yellow-600 mt-0.5" />
                <div>
                  <p className="font-medium text-yellow-900">
                    Restore Compliance Rate
                  </p>
                  <p className="text-sm text-yellow-700">
                    Implement targeted training campaigns for departments below
                    95% compliance to restore overall compliance before next
                    audit.
                  </p>
                </div>
              </div>
            )}

            <div className="flex items-start gap-3 p-4 bg-blue-50 border border-blue-200 rounded-lg">
              <Calendar className="size-5 text-blue-600 mt-0.5" />
              <div>
                <p className="font-medium text-blue-900">
                  Monitor Upcoming Deadlines
                </p>
                <p className="text-sm text-blue-700">
                  Track employees with training due within the next 30 days to
                  prevent compliance drops.
                </p>
              </div>
            </div>

            <div className="flex items-start gap-3 p-4 bg-green-50 border border-green-200 rounded-lg">
              <CheckCircle2 className="size-5 text-green-600 mt-0.5" />
              <div>
                <p className="font-medium text-green-900">
                  Maintain Audit Readiness
                </p>
                <p className="text-sm text-green-700">
                  Continue regular compliance monitoring and ensure all training
                  records are audit-ready with complete documentation.
                </p>
              </div>
            </div>
          </div>
        </div>

        {/* Footer */}
        <div className="mt-8 text-center text-sm text-slate-500">
          <p>
            This report was generated from the Pharma LMS on {currentDate}
          </p>
          <p className="mt-1">21 CFR Part 11 & GxP Compliant</p>
        </div>
      </main>
    </div>
  );
}
