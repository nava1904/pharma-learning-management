import { useState } from "react";
import { useNavigate, useParams } from "react-router";
import { mockCourses } from "../data/mockData";
import {
  Save,
  ArrowLeft,
  Plus,
  Trash2,
  AlertCircle,
  BookOpen,
} from "lucide-react";

export function CourseBuilder() {
  const navigate = useNavigate();
  const { courseId } = useParams();

  const existingCourse = courseId
    ? mockCourses.find((c) => c.id === courseId)
    : null;

  const [formData, setFormData] = useState({
    title: existingCourse?.title || "",
    sopNumber: existingCourse?.sopNumber || "",
    version: existingCourse?.version || "",
    description: existingCourse?.description || "",
    content: existingCourse?.content || "",
    minimumReadTime: existingCourse?.minimumReadTime || 180,
    expiryMonths: existingCourse?.expiryMonths || 12,
    passingScore: 80,
  });

  const [questions, setQuestions] = useState([
    {
      id: "1",
      question: "",
      options: ["", "", "", ""],
      correctAnswer: 0,
    },
  ]);

  const handleSave = () => {
    alert(
      `Course ${existingCourse ? "updated" : "created"} successfully!\n\nNext Steps:\n1. Submit for QA approval\n2. QA reviews and approves\n3. Course released to production\n4. Available for assignment`
    );
    navigate("/admin");
  };

  const addQuestion = () => {
    setQuestions([
      ...questions,
      {
        id: Date.now().toString(),
        question: "",
        options: ["", "", "", ""],
        correctAnswer: 0,
      },
    ]);
  };

  const removeQuestion = (id: string) => {
    setQuestions(questions.filter((q) => q.id !== id));
  };

  const updateQuestion = (
    id: string,
    field: string,
    value: string | number | string[]
  ) => {
    setQuestions(
      questions.map((q) => (q.id === id ? { ...q, [field]: value } : q))
    );
  };

  return (
    <div className="min-h-screen bg-slate-50">
      {/* Header */}
      <header className="bg-white border-b border-slate-200 sticky top-0 z-10">
        <div className="max-w-5xl mx-auto px-6 py-4">
          <div className="flex items-center justify-between">
            <div className="flex items-center gap-3">
              <button
                onClick={() => navigate("/admin")}
                className="p-2 hover:bg-slate-100 rounded-lg"
              >
                <ArrowLeft className="size-5" />
              </button>
              <div>
                <h1 className="text-xl font-bold text-slate-900">
                  {existingCourse ? "Edit Course" : "Create New Course"}
                </h1>
                <p className="text-sm text-slate-600">
                  Build training content and assessments
                </p>
              </div>
            </div>

            <div className="flex items-center gap-3">
              <button
                onClick={() => navigate("/admin")}
                className="px-4 py-2 border border-slate-300 text-slate-700 rounded-lg hover:bg-slate-100"
              >
                Cancel
              </button>
              <button
                onClick={handleSave}
                className="px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700 flex items-center gap-2"
              >
                <Save className="size-4" />
                Save & Submit for QA
              </button>
            </div>
          </div>
        </div>
      </header>

      <main className="max-w-5xl mx-auto px-6 py-8">
        {/* Info Banner */}
        <div className="bg-blue-50 border border-blue-200 rounded-lg p-4 mb-8">
          <div className="flex items-start gap-3">
            <BookOpen className="size-5 text-blue-600 mt-0.5" />
            <div>
              <p className="font-semibold text-blue-900 mb-1">
                Course Creation Workflow
              </p>
              <p className="text-sm text-blue-700">
                After saving, this course will be submitted for QA approval. Once
                approved, it will be available for assignment to employees.
              </p>
            </div>
          </div>
        </div>

        {/* Course Information */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-4">
            Course Information
          </h2>
          <div className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Course Title
                </label>
                <input
                  type="text"
                  value={formData.title}
                  onChange={(e) =>
                    setFormData({ ...formData, title: e.target.value })
                  }
                  placeholder="e.g., Sterile Filling SOP"
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  SOP Number
                </label>
                <input
                  type="text"
                  value={formData.sopNumber}
                  onChange={(e) =>
                    setFormData({ ...formData, sopNumber: e.target.value })
                  }
                  placeholder="e.g., SOP-105"
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
            </div>

            <div className="grid grid-cols-3 gap-4">
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Version
                </label>
                <input
                  type="text"
                  value={formData.version}
                  onChange={(e) =>
                    setFormData({ ...formData, version: e.target.value })
                  }
                  placeholder="e.g., 3.0"
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Min. Read Time (seconds)
                </label>
                <input
                  type="number"
                  value={formData.minimumReadTime}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      minimumReadTime: parseInt(e.target.value),
                    })
                  }
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
              <div>
                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Expiry (months)
                </label>
                <input
                  type="number"
                  value={formData.expiryMonths}
                  onChange={(e) =>
                    setFormData({
                      ...formData,
                      expiryMonths: parseInt(e.target.value),
                    })
                  }
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />
              </div>
            </div>

            <div>
              <label className="block text-sm font-medium text-slate-700 mb-2">
                Description
              </label>
              <textarea
                value={formData.description}
                onChange={(e) =>
                  setFormData({ ...formData, description: e.target.value })
                }
                rows={2}
                placeholder="Brief description of the training course..."
                className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
              />
            </div>
          </div>
        </div>

        {/* Course Content */}
        <div className="bg-white rounded-lg border border-slate-200 p-6 mb-6">
          <h2 className="text-lg font-semibold text-slate-900 mb-4">
            Course Content
          </h2>
          <div>
            <label className="block text-sm font-medium text-slate-700 mb-2">
              SOP Content (Markdown supported)
            </label>
            <textarea
              value={formData.content}
              onChange={(e) =>
                setFormData({ ...formData, content: e.target.value })
              }
              rows={20}
              placeholder="Enter the SOP content here. Use markdown formatting:&#10;# Main Heading&#10;## Sub Heading&#10;### Section&#10;- Bullet points"
              className="w-full px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent font-mono text-sm"
            />
          </div>
        </div>

        {/* Assessment Builder */}
        <div className="bg-white rounded-lg border border-slate-200 p-6">
          <div className="flex items-center justify-between mb-4">
            <div>
              <h2 className="text-lg font-semibold text-slate-900">
                Assessment Questions
              </h2>
              <p className="text-sm text-slate-600">
                Passing score: {formData.passingScore}%
              </p>
            </div>
            <button
              onClick={addQuestion}
              className="flex items-center gap-2 px-4 py-2 bg-indigo-600 text-white rounded-lg hover:bg-indigo-700"
            >
              <Plus className="size-4" />
              Add Question
            </button>
          </div>

          <div className="space-y-6">
            {questions.map((q, index) => (
              <div
                key={q.id}
                className="border border-slate-200 rounded-lg p-4"
              >
                <div className="flex items-start justify-between mb-4">
                  <label className="block text-sm font-medium text-slate-700">
                    Question {index + 1}
                  </label>
                  {questions.length > 1 && (
                    <button
                      onClick={() => removeQuestion(q.id)}
                      className="p-1 text-red-600 hover:bg-red-50 rounded"
                    >
                      <Trash2 className="size-4" />
                    </button>
                  )}
                </div>
                <input
                  type="text"
                  value={q.question}
                  onChange={(e) =>
                    updateQuestion(q.id, "question", e.target.value)
                  }
                  placeholder="Enter your question..."
                  className="w-full px-4 py-2 border border-slate-300 rounded-lg mb-4 focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                />

                <label className="block text-sm font-medium text-slate-700 mb-2">
                  Answer Options
                </label>
                <div className="space-y-2">
                  {q.options.map((option, optIndex) => (
                    <div key={optIndex} className="flex items-center gap-2">
                      <input
                        type="radio"
                        name={`correct-${q.id}`}
                        checked={q.correctAnswer === optIndex}
                        onChange={() =>
                          updateQuestion(q.id, "correctAnswer", optIndex)
                        }
                        className="size-4 text-indigo-600"
                      />
                      <input
                        type="text"
                        value={option}
                        onChange={(e) => {
                          const newOptions = [...q.options];
                          newOptions[optIndex] = e.target.value;
                          updateQuestion(q.id, "options", newOptions);
                        }}
                        placeholder={`Option ${optIndex + 1}`}
                        className="flex-1 px-4 py-2 border border-slate-300 rounded-lg focus:ring-2 focus:ring-indigo-500 focus:border-transparent"
                      />
                    </div>
                  ))}
                </div>
                <p className="text-xs text-slate-500 mt-2">
                  Select the correct answer by clicking the radio button
                </p>
              </div>
            ))}
          </div>

          {questions.length === 0 && (
            <div className="text-center py-12">
              <AlertCircle className="size-12 text-slate-400 mx-auto mb-4" />
              <p className="text-slate-600">
                No questions added yet. Click "Add Question" to create
                assessment questions.
              </p>
            </div>
          )}
        </div>
      </main>
    </div>
  );
}
