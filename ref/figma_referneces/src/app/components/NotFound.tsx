import { useNavigate } from "react-router";
import { AlertCircle, Home } from "lucide-react";

export function NotFound() {
  const navigate = useNavigate();

  return (
    <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
      <div className="text-center">
        <div className="inline-flex items-center justify-center size-16 bg-red-100 rounded-full mb-4">
          <AlertCircle className="size-8 text-red-600" />
        </div>
        <h1 className="text-4xl font-bold text-slate-900 mb-2">404</h1>
        <h2 className="text-xl font-semibold text-slate-900 mb-4">
          Page Not Found
        </h2>
        <p className="text-slate-600 mb-8 max-w-md">
          The page you are looking for doesn't exist or has been moved.
        </p>
        <button
          onClick={() => navigate("/")}
          className="inline-flex items-center gap-2 px-6 py-3 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors"
        >
          <Home className="size-4" />
          <span>Return to Login</span>
        </button>
      </div>
    </div>
  );
}
