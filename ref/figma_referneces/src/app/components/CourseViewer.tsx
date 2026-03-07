import { useState, useEffect } from "react";
import { useParams, useNavigate } from "react-router";
import { mockCourses, mockUsers } from "../data/mockData";
import {
  BookOpen,
  Clock,
  AlertCircle,
  CheckCircle2,
  ArrowLeft,
  FileText,
} from "lucide-react";

export function CourseViewer() {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [readTime, setReadTime] = useState(0);
  const [canProceed, setCanProceed] = useState(false);
  const [showWarning, setShowWarning] = useState(false);

  const course = mockCourses.find((c) => c.id === courseId);
  const currentUser = mockUsers[0];

  useEffect(() => {
    if (!course) return;

    const interval = setInterval(() => {
      setReadTime((prev) => {
        const newTime = prev + 1;
        if (newTime >= course.minimumReadTime) {
          setCanProceed(true);
        }
        return newTime;
      });
    }, 1000);

    return () => clearInterval(interval);
  }, [course]);

  if (!course) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <AlertCircle className="size-12 text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-slate-900">
            Course Not Found
          </h2>
          <button
            onClick={() => navigate("/employee")}
            className="mt-4 px-4 py-2 bg-indigo-600 text-white rounded-lg"
          >
            Back to Dashboard
          </button>
        </div>
      </div>
    );
  }

  const progress = Math.min(
    (readTime / course.minimumReadTime) * 100,
    100
  );
  const remainingSeconds = Math.max(course.minimumReadTime - readTime, 0);
  const minutes = Math.floor(remainingSeconds / 60);
  const seconds = remainingSeconds % 60;

  const handleProceedToAssessment = () => {
    if (!canProceed) {
      setShowWarning(true);
      setTimeout(() => setShowWarning(false), 3000);
      return;
    }
    navigate(`/assessment/${courseId}`);
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200 sticky top-0 z-10">
        <div className="max-w-5xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <button
              onClick={() => navigate("/employee")}
              className="flex items-center gap-2 text-slate-600 hover:text-slate-900"
            >
              <ArrowLeft className="size-4" />
              <span className="text-sm">Back to Dashboard</span>
            </button>
            <div className="flex items-center gap-4">
              <div className="text-right text-sm">
                <div className="text-slate-600">Reading Progress</div>
                <div className="font-semibold text-slate-900">
                  {Math.round(progress)}%
                </div>
              </div>
            </div>
          </div>
        </div>
      </header>

      {/* Progress Bar */}
      <div className="bg-white border-b border-slate-200">
        <div className="max-w-5xl mx-auto px-6">
          <div className="h-2 bg-slate-200 rounded-full overflow-hidden">
            <div
              className="h-full bg-indigo-600 transition-all duration-300"
              style={{ width: `${progress}%` }}
            />
          </div>
        </div>
      </div>

      {/* Warning Message */}
      {showWarning && (
        <div className="bg-red-50 border-b border-red-200">
          <div className="max-w-5xl mx-auto px-6 py-3">
            <div className="flex items-center gap-2 text-red-700">
              <AlertCircle className="size-4" />
              <span className="text-sm">
                Please complete the minimum reading time before proceeding to
                assessment.
              </span>
            </div>
          </div>
        </div>
      )}

      {/* Minimum Read Time Alert */}
      {!canProceed && (
        <div className="bg-amber-50 border-b border-amber-200">
          <div className="max-w-5xl mx-auto px-6 py-4">
            <div className="flex items-center gap-3">
              <Clock className="size-5 text-amber-600" />
              <div>
                <p className="font-medium text-amber-900">
                  Locked Content - Compliance Requirement
                </p>
                <p className="text-sm text-amber-700">
                  This SOP document requires a minimum reading time of{" "}
                  {course.minimumReadTime / 60} minutes. Time remaining:{" "}
                  <span className="font-semibold">
                    {minutes}:{seconds.toString().padStart(2, "0")}
                  </span>
                </p>
              </div>
            </div>
          </div>
        </div>
      )}

      <main className="max-w-5xl mx-auto px-6 py-8">
        {/* Course Header */}
        <div className="bg-white rounded-lg border border-slate-200 p-8 mb-6">
          <div className="flex items-start justify-between mb-4">
            <div>
              <div className="flex items-center gap-3 mb-2">
                <div className="bg-indigo-100 p-2 rounded-lg">
                  <FileText className="size-6 text-indigo-600" />
                </div>
                <div>
                  <h1 className="text-3xl font-bold text-slate-900">
                    {course.title}
                  </h1>
                  <p className="text-slate-600 mt-1">{course.description}</p>
                </div>
              </div>
            </div>
          </div>

          <div className="flex items-center gap-6 text-sm text-slate-600">
            <div className="flex items-center gap-2">
              <BookOpen className="size-4" />
              <span>
                {course.sopNumber} v{course.version}
              </span>
            </div>
            <div className="flex items-center gap-2">
              <Clock className="size-4" />
              <span>Min. Read Time: {course.minimumReadTime / 60} minutes</span>
            </div>
          </div>

          <div className="mt-6 pt-6 border-t border-slate-200">
            <div className="flex items-center gap-4">
              <div className="flex items-center gap-2 text-sm text-slate-600">
                <span className="font-medium">Created by:</span>
                <span>{mockUsers.find((u) => u.id === course.createdBy)?.name}</span>
              </div>
              <span className="text-slate-300">|</span>
              <div className="flex items-center gap-2 text-sm text-slate-600">
                <span className="font-medium">Approved by:</span>
                <span>
                  {mockUsers.find((u) => u.id === course.approvedBy)?.name}
                </span>
              </div>
              <span className="text-slate-300">|</span>
              <div className="flex items-center gap-2 text-sm">
                <span className="px-2 py-1 bg-green-100 text-green-700 rounded text-xs font-medium">
                  {course.status.toUpperCase()}
                </span>
              </div>
            </div>
          </div>
        </div>

        {/* SOP Content */}
        <div className="bg-white rounded-lg border border-slate-200 p-8 mb-6">
          <div className="prose prose-slate max-w-none">
            {course.content.split("\n").map((line, index) => {
              if (line.startsWith("# ")) {
                return (
                  <h1 key={index} className="text-2xl font-bold text-slate-900 mt-8 mb-4">
                    {line.replace("# ", "")}
                  </h1>
                );
              } else if (line.startsWith("## ")) {
                return (
                  <h2 key={index} className="text-xl font-semibold text-slate-900 mt-6 mb-3">
                    {line.replace("## ", "")}
                  </h2>
                );
              } else if (line.startsWith("### ")) {
                return (
                  <h3 key={index} className="text-lg font-semibold text-slate-900 mt-4 mb-2">
                    {line.replace("### ", "")}
                  </h3>
                );
              } else if (line.startsWith("- ")) {
                return (
                  <li key={index} className="text-slate-700 ml-6">
                    {line.replace("- ", "")}
                  </li>
                );
              } else if (line.trim() === "") {
                return <div key={index} className="h-2" />;
              } else {
                return (
                  <p key={index} className="text-slate-700 leading-relaxed mb-3">
                    {line}
                  </p>
                );
              }
            })}
          </div>
        </div>

        {/* Action Footer */}
        <div className="bg-white rounded-lg border border-slate-200 p-6">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              {canProceed ? (
                <>
                  <CheckCircle2 className="size-5 text-green-600" />
                  <div>
                    <p className="font-medium text-slate-900">
                      Reading Time Completed
                    </p>
                    <p className="text-sm text-slate-600">
                      You may now proceed to the assessment
                    </p>
                  </div>
                </>
              ) : (
                <>
                  <Clock className="size-5 text-amber-600" />
                  <div>
                    <p className="font-medium text-slate-900">
                      Please Complete Reading
                    </p>
                    <p className="text-sm text-slate-600">
                      {minutes}:{seconds.toString().padStart(2, "0")} remaining
                    </p>
                  </div>
                </>
              )}
            </div>
            <button
              onClick={handleProceedToAssessment}
              disabled={!canProceed}
              className={`px-6 py-3 rounded-lg font-medium transition-colors ${
                canProceed
                  ? "bg-indigo-600 text-white hover:bg-indigo-700"
                  : "bg-slate-200 text-slate-400 cursor-not-allowed"
              }`}
            >
              Proceed to Assessment
            </button>
          </div>
        </div>
      </main>
    </div>
  );
}
