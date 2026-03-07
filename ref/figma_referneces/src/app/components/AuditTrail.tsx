import { useState } from "react";
import { useNavigate } from "react-router";
import { mockAuditLogs } from "../data/mockData";
import {
  FileText,
  ArrowLeft,
  Search,
  Filter,
  Download,
  CheckCircle2,
} from "lucide-react";

export function AuditTrail() {
  const navigate = useNavigate();
  const [searchTerm, setSearchTerm] = useState("");
  const [filterAction, setFilterAction] = useState("all");

  const actionTypes = [
    "all",
    "LOGIN",
    "COURSE_ACCESS",
    "TRAINING_ASSIGNED",
    "COURSE_APPROVED",
    "ASSESSMENT_COMPLETED",
    "ELECTRONIC_SIGNATURE",
    "CERTIFICATE_ISSUED",
  ];

  const filteredLogs = mockAuditLogs.filter((log) => {
    const matchesSearch =
      log.userName.toLowerCase().includes(searchTerm.toLowerCase()) ||
      log.details.toLowerCase().includes(searchTerm.toLowerCase());
    const matchesFilter =
      filterAction === "all" || log.action === filterAction;
    return matchesSearch && matchesFilter;
  });

  const getActionColor = (action: string) => {
    switch (action) {
      case "LOGIN":
        return "bg-blue-100 text-blue-800";
      case "COURSE_APPROVED":
        return "bg-green-100 text-green-800";
      case "ELECTRONIC_SIGNATURE":
        return "bg-purple-100 text-purple-800";
      case "CERTIFICATE_ISSUED":
        return "bg-amber-100 text-amber-800";
      case "ASSESSMENT_COMPLETED":
        return "bg-indigo-100 text-indigo-800";
      default:
        return "bg-slate-100 text-slate-800";
    }
  };

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
                  Audit Trail
                </h1>
                <p className="text-sm text-slate-600">
                  Immutable record of all LMS activities
                </p>
              </div>
            </div>

            <button className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700">
              <Download className="size-4" />
              <span className="text-sm">Export for Inspection</span>
            </button>
          </div>
        </div>
      </header>

      <main className="max-w-7xl mx-auto px-6 py-8">
        {/* Compliance Banner */}
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-6">
          <div className="flex items-start gap-3">
            <CheckCircle2 className="size-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-semibold text-blue-900 mb-1">
                21 CFR Part 11 Compliant Audit Trail
              </p>
              <p className="text-sm text-blue-700">
                All entries are NTP-synchronized, immutable, and include user
                attribution. This audit trail meets regulatory requirements for
                FDA inspections and provides complete traceability of training
                activities.
              </p>
            </div>
          </div>
        </div>

        {/* Filters */}
        <div className="bg-white rounded-lg border border-slate-200 p-4 mb-6">
          <div className="flex gap-4">
            <div className="flex-1 relative">
              <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 size-4 text-slate-400" />
              <input
                type="text"
                value={searchTerm}
                onChange={(e) => setSearchTerm(e.target.value)}
                placeholder="Search by user or activity..."
                className="w-full pl-10 pr-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              />
            </div>
            <div className="relative">
              <Filter className="absolute left-3 top-1/2 transform -translate-y-1/2 size-4 text-slate-400" />
              <select
                value={filterAction}
                onChange={(e) => setFilterAction(e.target.value)}
                className="pl-10 pr-8 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent appearance-none"
              >
                {actionTypes.map((action) => (
                  <option key={action} value={action}>
                    {action === "all" ? "All Actions" : action}
                  </option>
                ))}
              </select>
            </div>
          </div>
          <p className="text-sm text-slate-600 mt-2">
            Showing {filteredLogs.length} of {mockAuditLogs.length} entries
          </p>
        </div>

        {/* Audit Log Entries */}
        <div className="bg-white rounded-lg border border-slate-200">
          <div className="divide-y divide-slate-200">
            {filteredLogs.map((log) => (
              <div key={log.id} className="p-6 hover:bg-slate-50">
                <div className="flex items-start gap-4">
                  <div className="flex-shrink-0">
                    <FileText className="size-5 text-slate-400" />
                  </div>
                  <div className="flex-1">
                    <div className="flex items-start justify-between mb-2">
                      <div className="flex items-center gap-3">
                        <span
                          className={`px-2 py-1 rounded text-xs font-medium ${getActionColor(
                            log.action
                          )}`}
                        >
                          {log.action}
                        </span>
                        <span className="font-semibold text-slate-900">
                          {log.userName}
                        </span>
                        <span className="text-sm text-slate-500">
                          ID: {log.userId}
                        </span>
                      </div>
                      <div className="text-right">
                        <div className="text-sm font-medium text-slate-900">
                          {new Date(log.timestamp).toLocaleString()}
                        </div>
                        <div className="flex items-center gap-2 text-xs text-slate-500">
                          <span>IP: {log.ipAddress}</span>
                          {log.ntpSync && (
                            <span className="flex items-center gap-1 text-green-600">
                              <CheckCircle2 className="size-3" />
                              NTP Sync
                            </span>
                          )}
                        </div>
                      </div>
                    </div>
                    <p className="text-sm text-slate-700">{log.details}</p>
                  </div>
                </div>
              </div>
            ))}
          </div>

          {filteredLogs.length === 0 && (
            <div className="p-12 text-center">
              <FileText className="size-12 text-slate-400 mx-auto mb-4" />
              <h3 className="text-lg font-semibold text-slate-900 mb-2">
                No Entries Found
              </h3>
              <p className="text-slate-600">
                Try adjusting your search or filter criteria.
              </p>
            </div>
          )}
        </div>

        {/* Legend */}
        <div className="mt-6 bg-slate-100 rounded-lg p-4">
          <h3 className="text-sm font-semibold text-slate-900 mb-3">
            Audit Trail Legend
          </h3>
          <div className="grid grid-cols-2 md:grid-cols-4 gap-4 text-sm">
            <div>
              <span className="font-medium text-slate-700">Attributable:</span>
              <p className="text-slate-600">User ID & Name recorded</p>
            </div>
            <div>
              <span className="font-medium text-slate-700">Legible:</span>
              <p className="text-slate-600">Human-readable format</p>
            </div>
            <div>
              <span className="font-medium text-slate-700">
                Contemporaneous:
              </span>
              <p className="text-slate-600">Real-time NTP timestamps</p>
            </div>
            <div>
              <span className="font-medium text-slate-700">Original:</span>
              <p className="text-slate-600">Immutable entries</p>
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}
