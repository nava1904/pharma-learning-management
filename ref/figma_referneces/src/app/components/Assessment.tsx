import { useState } from "react";
import { useParams, useNavigate } from "react-router";
import {
  mockCourses,
  mockAssessments,
  mockUsers,
  mockCertifications,
} from "../data/mockData";
import {
  CheckCircle2,
  XCircle,
  AlertCircle,
  ArrowRight,
  FileCheck,
} from "lucide-react";

export function Assessment() {
  const { courseId } = useParams();
  const navigate = useNavigate();
  const [currentQuestion, setCurrentQuestion] = useState(0);
  const [answers, setAnswers] = useState<Record<number, number>>({});
  const [showResults, setShowResults] = useState(false);
  const [showSignature, setShowSignature] = useState(false);
  const [signature, setSignature] = useState({
    username: "",
    password: "",
  });

  const course = mockCourses.find((c) => c.id === courseId);
  const assessment = mockAssessments.find(
    (a) => a.courseId === courseId
  );
  const currentUser = mockUsers[0];

  if (!course || !assessment) {
    return (
      <div className="min-h-screen flex items-center justify-center">
        <div className="text-center">
          <AlertCircle className="size-12 text-red-500 mx-auto mb-4" />
          <h2 className="text-xl font-semibold text-slate-900">
            Assessment Not Found
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

  const questions = assessment.questions;
  const question = questions[currentQuestion];
  const isLastQuestion = currentQuestion === questions.length - 1;
  const answeredAll = Object.keys(answers).length === questions.length;

  const calculateScore = () => {
    let correct = 0;
    questions.forEach((q, index) => {
      if (answers[index] === q.correctAnswer) {
        correct++;
      }
    });
    return Math.round((correct / questions.length) * 100);
  };

  const handleNext = () => {
    if (currentQuestion < questions.length - 1) {
      setCurrentQuestion(currentQuestion + 1);
    }
  };

  const handlePrevious = () => {
    if (currentQuestion > 0) {
      setCurrentQuestion(currentQuestion - 1);
    }
  };

  const handleSubmit = () => {
    setShowResults(true);
  };

  const handleSign = () => {
    if (!signature.username || !signature.password) {
      alert("Please enter both username and password");
      return;
    }

    // Generate mock certification
    const certId = `cert${Date.now()}`;
    const score = calculateScore();

    // In real app, this would create the certification
    navigate(`/certificate/${certId}?score=${score}&courseId=${courseId}`);
  };

  if (showResults) {
    const score = calculateScore();
    const passed = score >= assessment.passingScore;

    return (
      <div className="min-h-screen bg-slate-50 flex items-center justify-center p-6">
        <div className="w-full max-w-2xl">
          <div className="bg-white rounded-xl border border-slate-200 p-8">
            {passed ? (
              <>
                <div className="text-center mb-8">
                  <div className="inline-flex items-center justify-center size-16 bg-green-100 rounded-full mb-4">
                    <CheckCircle2 className="size-8 text-green-600" />
                  </div>
                  <h2 className="text-2xl font-bold text-slate-900 mb-2">
                    Assessment Passed!
                  </h2>
                  <p className="text-slate-600">
                    Congratulations! You have successfully completed the assessment.
                  </p>
                </div>

                <div className="bg-green-50 border border-green-200 rounded-lg p-6 mb-8">
                  <div className="flex items-center justify-between mb-4">
                    <span className="text-slate-700">Your Score</span>
                    <span className="text-3xl font-bold text-green-600">
                      {score}%
                    </span>
                  </div>
                  <div className="h-3 bg-green-200 rounded-full overflow-hidden">
                    <div
                      className="h-full bg-green-600 transition-all"
                      style={{ width: `${score}%` }}
                    />
                  </div>
                  <p className="text-sm text-slate-600 mt-2">
                    Passing Score: {assessment.passingScore}%
                  </p>
                </div>

                {!showSignature ? (
                  <button
                    onClick={() => setShowSignature(true)}
                    className="w-full bg-indigo-600 text-white py-3 rounded-lg hover:bg-indigo-700 transition-colors"
                  >
                    Proceed to Electronic Signature
                  </button>
                ) : (
                  <div className="space-y-4">
                    <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-4">
                      <div className="flex items-start gap-3">
                        <FileCheck className="size-5 text-blue-600 mt-0.5" />
                        <div>
                          <p className="font-semibold text-blue-900 mb-1">
                            Electronic Signature Required
                          </p>
                          <p className="text-sm text-blue-700">
                            Per 21 CFR Part 11, you must electronically sign to
                            confirm training completion. By signing, you
                            acknowledge completion and understanding of this
                            training.
                          </p>
                        </div>
                      </div>
                    </div>

                    <div>
                      <label className="block text-sm font-medium text-slate-700 mb-2">
                        Username
                      </label>
                      <input
                        type="text"
                        value={signature.username}
                        onChange={(e) =>
                          setSignature({ ...signature, username: e.target.value })
                        }
                        placeholder="Enter your username"
                        className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                      />
                    </div>

                    <div>
                      <label className="block text-sm font-medium text-slate-700 mb-2">
                        Password
                      </label>
                      <input
                        type="password"
                        value={signature.password}
                        onChange={(e) =>
                          setSignature({ ...signature, password: e.target.value })
                        }
                        placeholder="Re-enter your password"
                        className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                      />
                    </div>

                    <div className="bg-slate-50 border border-slate-200 rounded-lg p-4 text-sm text-slate-600">
                      <p className="font-medium text-slate-900 mb-2">
                        Meaning of Signature:
                      </p>
                      <p>
                        "I confirm that I have completed the training '{course.title}' 
                        and understand the content. I acknowledge my responsibility 
                        to follow these procedures."
                      </p>
                    </div>

                    <button
                      onClick={handleSign}
                      className="w-full bg-indigo-600 text-white py-3 rounded-lg hover:bg-indigo-700 transition-colors"
                    >
                      Sign and Complete Training
                    </button>
                  </div>
                )}
              </>
            ) : (
              <>
                <div className="text-center mb-8">
                  <div className="inline-flex items-center justify-center size-16 bg-red-100 rounded-full mb-4">
                    <XCircle className="size-8 text-red-600" />
                  </div>
                  <h2 className="text-2xl font-bold text-slate-900 mb-2">
                    Assessment Not Passed
                  </h2>
                  <p className="text-slate-600">
                    You need to review the material and retake the assessment.
                  </p>
                </div>

                <div className="bg-red-50 border border-red-200 rounded-lg p-6 mb-8">
                  <div className="flex items-center justify-between mb-4">
                    <span className="text-slate-700">Your Score</span>
                    <span className="text-3xl font-bold text-red-600">
                      {score}%
                    </span>
                  </div>
                  <div className="h-3 bg-red-200 rounded-full overflow-hidden">
                    <div
                      className="h-full bg-red-600 transition-all"
                      style={{ width: `${score}%` }}
                    />
                  </div>
                  <p className="text-sm text-slate-600 mt-2">
                    Required Passing Score: {assessment.passingScore}%
                  </p>
                </div>

                <div className="flex gap-3">
                  <button
                    onClick={() => navigate(`/course/${courseId}`)}
                    className="flex-1 bg-slate-100 text-slate-700 py-3 rounded-lg hover:bg-slate-200 transition-colors"
                  >
                    Review Material
                  </button>
                  <button
                    onClick={() => {
                      setShowResults(false);
                      setCurrentQuestion(0);
                      setAnswers({});
                    }}
                    className="flex-1 bg-indigo-600 text-white py-3 rounded-lg hover:bg-indigo-700 transition-colors"
                  >
                    Retake Assessment
                  </button>
                </div>
              </>
            )}
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="min-h-screen bg-slate-50">
      <header className="bg-white border-b border-slate-200">
        <div className="max-w-4xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div>
              <h1 className="text-xl font-bold text-slate-900">
                Knowledge Assessment
              </h1>
              <p className="text-sm text-slate-600">{course.title}</p>
            </div>
            <div className="text-right">
              <div className="text-sm text-slate-600">Question Progress</div>
              <div className="font-semibold text-slate-900">
                {currentQuestion + 1} / {questions.length}
              </div>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-4xl mx-auto px-6 py-8">
        {/* Progress Indicator */}
        <div className="flex gap-2 mb-8">
          {questions.map((_, index) => (
            <div
              key={index}
              className={`h-2 flex-1 rounded-full ${
                index === currentQuestion
                  ? "bg-indigo-600"
                  : answers[index] !== undefined
                  ? "bg-green-400"
                  : "bg-slate-200"
              }`}
            />
          ))}
        </div>

        {/* Question Card */}
        <div className="bg-white rounded-lg border border-slate-200 p-8 mb-6">
          <div className="mb-6">
            <span className="text-sm text-slate-500">
              Question {currentQuestion + 1} of {questions.length}
            </span>
            <h2 className="text-xl font-semibold text-slate-900 mt-2">
              {question.question}
            </h2>
          </div>

          <div className="space-y-3">
            {question.options.map((option, index) => (
              <button
                key={index}
                onClick={() =>
                  setAnswers({ ...answers, [currentQuestion]: index })
                }
                className={`w-full text-left p-4 rounded-lg border-2 transition-all ${
                  answers[currentQuestion] === index
                    ? "border-indigo-600 bg-indigo-50"
                    : "border-slate-200 hover:border-slate-300 bg-white"
                }`}
              >
                <div className="flex items-center gap-3">
                  <div
                    className={`size-5 rounded-full border-2 flex items-center justify-center ${
                      answers[currentQuestion] === index
                        ? "border-indigo-600 bg-indigo-600"
                        : "border-slate-300"
                    }`}
                  >
                    {answers[currentQuestion] === index && (
                      <div className="size-2 bg-white rounded-full" />
                    )}
                  </div>
                  <span className="text-slate-900">{option}</span>
                </div>
              </button>
            ))}
          </div>
        </div>

        {/* Navigation */}
        <div className="flex items-center justify-between">
          <button
            onClick={handlePrevious}
            disabled={currentQuestion === 0}
            className="px-6 py-2 border border-slate-300 text-slate-700 rounded-lg hover:bg-slate-50 disabled:opacity-50 disabled:cursor-not-allowed transition-colors"
          >
            Previous
          </button>

          <div className="text-sm text-slate-600">
            {Object.keys(answers).length} of {questions.length} answered
          </div>

          {isLastQuestion ? (
            <button
              onClick={handleSubmit}
              disabled={!answeredAll}
              className="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 disabled:bg-slate-300 disabled:cursor-not-allowed transition-colors flex items-center gap-2"
            >
              Submit Assessment
              <ArrowRight className="size-4" />
            </button>
          ) : (
            <button
              onClick={handleNext}
              className="px-6 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 transition-colors flex items-center gap-2"
            >
              Next Question
              <ArrowRight className="size-4" />
            </button>
          )}
        </div>

        {/* Submit Warning */}
        {!answeredAll && (
          <div className="mt-6 bg-amber-50 border border-amber-200 rounded-lg p-4">
            <div className="flex items-center gap-2 text-amber-800 text-sm">
              <AlertCircle className="size-4" />
              <span>
                Please answer all questions before submitting the assessment.
              </span>
            </div>
          </div>
        )}
      </main>
    </div>
  );
}
