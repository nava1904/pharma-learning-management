import { BookOpen, Clock, CheckCircle2 } from 'lucide-react';
import { Link } from 'react-router';

const lessons = [
  {
    id: 1,
    title: 'GMP Fundamentals',
    course: 'GMP Training',
    duration: '45 min',
    completed: true,
    progress: 100
  },
  {
    id: 2,
    title: 'Documentation Requirements',
    course: 'GMP Training',
    duration: '60 min',
    completed: true,
    progress: 100
  },
  {
    id: 3,
    title: 'Cleanroom Protocols',
    course: 'GMP Training',
    duration: '50 min',
    completed: false,
    progress: 65
  },
  {
    id: 4,
    title: 'PPE and Safety Equipment',
    course: 'Safety SOP',
    duration: '40 min',
    completed: true,
    progress: 100
  },
  {
    id: 5,
    title: 'Emergency Procedures',
    course: 'Safety SOP',
    duration: '55 min',
    completed: false,
    progress: 30
  },
  {
    id: 6,
    title: 'Testing Methods',
    course: 'Quality Control',
    duration: '70 min',
    completed: false,
    progress: 0
  }
];

export function Lessons() {
  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-semibold mb-2">My Lessons</h1>
        <p className="text-gray-600">Track your lesson progress across all courses</p>
      </div>

      {/* Lessons List */}
      <div className="bg-white rounded-lg border border-gray-200">
        {lessons.map((lesson, index) => (
          <div
            key={lesson.id}
            className={`p-6 hover:bg-gray-50 transition-colors cursor-pointer ${
              index !== lessons.length - 1 ? 'border-b border-gray-200' : ''
            }`}
          >
            <div className="flex items-center gap-6">
              {/* Lesson Number */}
              <div className="w-12 h-12 bg-emerald-100 text-emerald-700 rounded-lg flex items-center justify-center font-semibold flex-shrink-0">
                {lesson.id}
              </div>

              {/* Lesson Info */}
              <div className="flex-1">
                <div className="flex items-center gap-3 mb-2">
                  <h3 className="text-lg font-semibold">{lesson.title}</h3>
                  {lesson.completed && (
                    <CheckCircle2 className="w-5 h-5 text-emerald-600" />
                  )}
                </div>
                <div className="flex items-center gap-4 text-sm text-gray-600">
                  <div className="flex items-center gap-2">
                    <BookOpen className="w-4 h-4" />
                    <span>{lesson.course}</span>
                  </div>
                  <div className="flex items-center gap-2">
                    <Clock className="w-4 h-4" />
                    <span>{lesson.duration}</span>
                  </div>
                </div>

                {/* Progress Bar */}
                {lesson.progress > 0 && lesson.progress < 100 && (
                  <div className="mt-3">
                    <div className="flex items-center justify-between text-sm mb-2">
                      <span className="text-gray-600">Progress</span>
                      <span className="font-medium text-emerald-600">{lesson.progress}%</span>
                    </div>
                    <div className="w-full bg-gray-200 rounded-full h-2">
                      <div
                        className="bg-emerald-600 h-2 rounded-full transition-all"
                        style={{ width: `${lesson.progress}%` }}
                      />
                    </div>
                  </div>
                )}
              </div>

              {/* Action Button */}
              <Link
                to={`/courses/${lesson.course.toLowerCase().replace(/\s+/g, '-')}`}
                className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
              >
                {lesson.completed ? 'Review' : 'Continue'}
              </Link>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
