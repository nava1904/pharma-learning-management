import { useParams, Link } from 'react-router';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Play, CheckCircle2, Circle, ChevronRight, Calendar, Users, Award } from 'lucide-react';

const courseData = {
  'gmp-training': {
    title: 'GMP Training',
    subtitle: 'Good Manufacturing Practice (GMP) - 73% GMP Compliance personalized altering quality/safety Meets FDA/EU/ICH SOP Best training/Highrates',
    image: 'https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    progress: 82,
    modules: [
      {
        id: 1,
        title: 'Introduction',
        description: 'Overview of GMP principles and regulations',
        duration: '2h 15m',
        completed: true,
        image: 'https://images.unsplash.com/photo-1772764331317-4934ee566292?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpY2FsJTIwdHJhaW5pbmclMjBjbGFzc3Jvb218ZW58MXx8fHwxNzczNTIwNjE4fDA&ixlib=rb-4.1.0&q=80&w=1080'
      },
      {
        id: 2,
        title: 'Safety Procedures',
        description: 'Safety protocols and emergency procedures',
        duration: '3h 30m',
        completed: true
      },
      {
        id: 3,
        title: 'Quality Control',
        description: 'QC testing methods and documentation',
        duration: '2h 45m',
        completed: false
      }
    ],
    objectives: [
      'Understand GMP guidelines and their importance in pharmaceutical manufacturing',
      'Learn proper documentation practices and record keeping requirements',
      'Master contamination control and cleanroom protocols',
      'Apply quality assurance principles in daily operations'
    ]
  }
};

export function CourseDetail() {
  const { id } = useParams();
  const course = courseData[id as keyof typeof courseData];

  if (!course) {
    return <div>Course not found</div>;
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold mb-2">{course.title}</h1>
          <p className="text-gray-600 max-w-3xl">{course.subtitle}</p>
        </div>
        
        <div className="flex items-center gap-4">
          <div className="text-right">
            <p className="text-sm text-gray-600">Progress</p>
            <p className="text-xl font-semibold text-emerald-600">{course.progress}%</p>
          </div>
          <Link
            to="/assessments/gmp-compliance-quiz"
            className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
          >
            Take Exam
          </Link>
        </div>
      </div>

      <div className="grid grid-cols-3 gap-6">
        {/* Main Content */}
        <div className="col-span-2 space-y-6">
          {/* Video Player */}
          <div className="bg-white rounded-lg border border-gray-200 overflow-hidden">
            <div className="aspect-video bg-gray-900 relative">
              <ImageWithFallback
                src={course.image}
                alt={course.title}
                className="w-full h-full object-cover opacity-70"
              />
              <button className="absolute inset-0 flex items-center justify-center group">
                <div className="w-20 h-20 bg-white/90 rounded-full flex items-center justify-center group-hover:bg-white transition-colors">
                  <Play className="w-10 h-10 text-gray-900 ml-1" />
                </div>
              </button>
              
              {/* Video Controls */}
              <div className="absolute bottom-0 left-0 right-0 bg-gradient-to-t from-black/80 to-transparent p-4">
                <div className="flex items-center gap-4 text-white text-sm mb-2">
                  <span>00:00</span>
                  <div className="flex-1 bg-white/30 rounded-full h-1">
                    <div className="bg-white rounded-full h-1 w-1/3"></div>
                  </div>
                  <span>15:42</span>
                </div>
                <div className="flex items-center justify-between">
                  <span className="text-white font-medium">Playing</span>
                  <div className="flex gap-2">
                    <button className="w-8 h-8 bg-white/20 rounded hover:bg-white/30 transition-colors flex items-center justify-center">
                      <span className="text-xs">CC</span>
                    </button>
                    <button className="w-8 h-8 bg-white/20 rounded hover:bg-white/30 transition-colors flex items-center justify-center">
                      <span className="text-xs">⚙</span>
                    </button>
                    <button className="w-8 h-8 bg-white/20 rounded hover:bg-white/30 transition-colors flex items-center justify-center">
                      <span className="text-xs">⛶</span>
                    </button>
                  </div>
                </div>
              </div>
            </div>
          </div>

          {/* Course Objectives */}
          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <h2 className="text-lg font-semibold mb-4">Course Objectives</h2>
            <div className="space-y-4">
              {course.objectives.map((objective, index) => (
                <div key={index} className="flex gap-3">
                  <div className="w-6 h-6 rounded-full bg-emerald-100 text-emerald-700 flex items-center justify-center flex-shrink-0 mt-0.5">
                    <span className="text-xs font-semibold">{index + 1}</span>
                  </div>
                  <p className="text-gray-700">{objective}</p>
                </div>
              ))}
            </div>
          </div>

          {/* Module List */}
          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <h2 className="text-lg font-semibold mb-4">Course Modules</h2>
            <div className="space-y-3">
              {course.modules.map((module) => (
                <div
                  key={module.id}
                  className="flex items-center gap-4 p-4 border border-gray-200 rounded-lg hover:bg-gray-50 transition-colors cursor-pointer"
                >
                  {module.image && (
                    <div className="w-20 h-14 bg-gray-200 rounded overflow-hidden flex-shrink-0">
                      <ImageWithFallback
                        src={module.image}
                        alt={module.title}
                        className="w-full h-full object-cover"
                      />
                    </div>
                  )}
                  
                  <div className="flex-1">
                    <div className="flex items-center gap-2 mb-1">
                      <span className="text-sm font-medium text-gray-500">Module {module.id}</span>
                      {module.completed ? (
                        <CheckCircle2 className="w-4 h-4 text-emerald-600" />
                      ) : (
                        <Circle className="w-4 h-4 text-gray-300" />
                      )}
                    </div>
                    <h3 className="font-semibold mb-1">{module.title}</h3>
                    <p className="text-sm text-gray-600">{module.description}</p>
                  </div>
                  
                  <div className="text-sm text-gray-500">
                    {module.duration}
                  </div>
                  <ChevronRight className="w-5 h-5 text-gray-400" />
                </div>
              ))}
            </div>
          </div>
        </div>

        {/* Sidebar */}
        <div className="space-y-6">
          {/* User Info */}
          <div className="bg-white rounded-lg border border-gray-200 p-6 text-center">
            <div className="w-16 h-16 bg-gray-200 rounded-full mx-auto mb-3 overflow-hidden">
              <ImageWithFallback
                src="https://images.unsplash.com/photo-1576765608689-c0e8f69a46b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMGxhYm9yYXRvcnklMjBzY2llbnRpc3R8ZW58MXx8fHwxNzczNDk5MzUwfDA&ixlib=rb-4.1.0&q=80&w=1080"
                alt="User"
                className="w-full h-full object-cover"
              />
            </div>
            <p className="font-semibold">Shubham Yadav</p>
            <p className="text-sm text-gray-500">College Student</p>
          </div>

          {/* Calendar */}
          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <div className="flex items-center justify-between mb-4">
              <h3 className="font-semibold">March 2026</h3>
              <div className="flex gap-1">
                <button className="p-1 hover:bg-gray-100 rounded">‹</button>
                <button className="p-1 hover:bg-gray-100 rounded">›</button>
              </div>
            </div>
            <div className="grid grid-cols-7 gap-1 text-center text-sm">
              {['S', 'M', 'T', 'W', 'T', 'F', 'S'].map((day) => (
                <div key={day} className="text-gray-500 font-medium py-2">
                  {day}
                </div>
              ))}
              {Array.from({ length: 31 }, (_, i) => i + 1).map((day) => (
                <div
                  key={day}
                  className={`py-2 rounded ${
                    day === 15
                      ? 'bg-emerald-600 text-white font-semibold'
                      : day === 8 || day === 22
                      ? 'bg-gray-900 text-white'
                      : 'hover:bg-gray-100'
                  }`}
                >
                  {day}
                </div>
              ))}
            </div>
          </div>

          {/* Performance */}
          <div className="bg-white rounded-lg border border-gray-200 p-6">
            <h3 className="font-semibold mb-4">Performance</h3>
            <div className="space-y-3">
              <div className="flex items-center justify-between text-sm">
                <span className="text-gray-600">Overall Score</span>
                <span className="font-semibold">85%</span>
              </div>
              <div className="flex items-center justify-between text-sm">
                <span className="text-gray-600">Quizzes Passed</span>
                <span className="font-semibold">12/15</span>
              </div>
              <div className="flex items-center justify-between text-sm">
                <span className="text-gray-600">Time Spent</span>
                <span className="font-semibold">24h 30m</span>
              </div>
            </div>
          </div>

          {/* Next Lesson Button */}
          <button className="w-full px-6 py-3 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
            Mark Lesson
          </button>
        </div>
      </div>
    </div>
  );
}
