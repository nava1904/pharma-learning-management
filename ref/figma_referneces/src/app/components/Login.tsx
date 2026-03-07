import { useState } from "react";
import { useNavigate } from "react-router";
import { mockUsers } from "../data/mockData";
import { Building2, GraduationCap } from "lucide-react";

export function Login() {
  const navigate = useNavigate();
  const [selectedRole, setSelectedRole] = useState<string>("");

  const handleLogin = () => {
    if (!selectedRole) return;

    const roleMap: Record<string, string> = {
      employee: "/employee",
      admin: "/admin",
      qa: "/qa",
      sme: "/sme",
    };

    navigate(roleMap[selectedRole]);
  };

  return (
    <div className="min-h-screen flex items-center justify-center bg-gradient-to-br from-blue-50 to-indigo-100">
      <div className="w-full max-w-md">
        <div className="bg-white rounded-lg shadow-xl p-8">
          <div className="flex items-center justify-center mb-8">
            <div className="bg-indigo-600 p-3 rounded-lg">
              <GraduationCap className="size-8 text-white" />
            </div>
          </div>

          <div className="text-center mb-8">
            <h1 className="text-3xl font-bold text-slate-900 mb-2">
              Pharma LMS
            </h1>
            <p className="text-slate-600">
              Learning Management System
            </p>
            <p className="text-sm text-slate-500 mt-2">
              21 CFR Part 11 & GxP Compliant
            </p>
          </div>

          <div className="space-y-4">
            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Select Role to Continue
              </label>
              <select
                value={selectedRole}
                onChange={(e) => setSelectedRole(e.target.value)}
                className="w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              >
                <option value="">-- Choose a role --</option>
                <option value="employee">Employee / Trainee</option>
                <option value="admin">Training Administrator</option>
                <option value="qa">Quality Assurance (QA)</option>
                <option value="sme">Subject Matter Expert (SME)</option>
              </select>
            </div>

            <button
              onClick={handleLogin}
              disabled={!selectedRole}
              className="w-full bg-indigo-600 text-white py-3 rounded-lg hover:bg-indigo-700 disabled:bg-slate-300 disabled:cursor-not-allowed transition-colors"
            >
              Access LMS
            </button>
          </div>

          <div className="mt-8 pt-6 border-t border-slate-200">
            <h3 className="text-sm font-medium text-slate-700 mb-3">
              Demo Users:
            </h3>
            <div className="space-y-2 text-sm text-slate-600">
              {mockUsers.map((user) => (
                <div key={user.id} className="flex items-start gap-2">
                  <Building2 className="size-4 text-slate-400 mt-0.5" />
                  <div>
                    <div className="font-medium">{user.name}</div>
                    <div className="text-xs text-slate-500">
                      {user.jobRole} - {user.department}
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>

        <p className="text-center text-sm text-slate-600 mt-6">
          Session timeout: 15 minutes | NTP Synchronized
        </p>
      </div>
    </div>
  );
}
