import { Link } from 'react-router';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Clock, FileText, Award } from 'lucide-react';

const assessments = [
  {
    id: 'gmp-compliance-quiz',
    title: 'GMP Compliance Quiz',
    subtitle: 'Expert Required for Compliance Topics',
    image: 'https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    modules: [
      { id: 1, name: 'Introduction', progress: 100 },
      { id: 2, name: 'Safety Procedures', progress: 100 },
      { id: 3, name: 'Quality Control', progress: 84 }
    ],
    progress: 75,
    status: 'In Progress'
  },
  {
    id: 'safety-procedures-test',
    title: 'Safety Procedures Assessment',
    subtitle: 'Laboratory Safety Compliance Test',
    image: 'https://images.unsplash.com/photo-1772764331317-4934ee566292?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpY2FsJTIwdHJhaW5pbmclMjBjbGFzc3Jvb218ZW58MXx8fHwxNzczNTIwNjE4fDA&ixlib=rb-4.1.0&q=80&w=1080',
    modules: [
      { id: 1, name: 'PPE Usage', progress: 100 },
      { id: 2, name: 'Emergency Protocols', progress: 60 },
      { id: 3, name: 'Hazard Management', progress: 30 }
    ],
    progress: 63,
    status: 'In Progress'
  },
  {
    id: 'quality-assurance-exam',
    title: 'Quality Assurance Exam',
    subtitle: 'Comprehensive QA Testing',
    modules: [
      { id: 1, name: 'Documentation', progress: 100 },
      { id: 2, name: 'Testing Methods', progress: 100 },
      { id: 3, name: 'Validation', progress: 100 }
    ],
    progress: 100,
    status: 'Completed'
  }
];

export function Assessments() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold mb-2">Assessments</h1>
          <p className="text-gray-600">Test your knowledge and earn certifications</p>
        </div>
        
        <Link
          to="/history"
          className="flex items-center gap-2 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
        >
          <Clock className="w-4 h-4" />
          View History
        </Link>
      </div>

      {/* Assessment Cards */}
      <div className="space-y-6">
        {assessments.map((assessment) => (
          <div
            key={assessment.id}
            className="bg-white rounded-lg border border-gray-200 overflow-hidden hover:shadow-md transition-shadow"
          >
            <div className="p-6">
              <div className="flex gap-6">
                {/* Assessment Image */}
                {assessment.image && (
                  <div className="w-48 h-32 bg-gray-200 rounded-lg overflow-hidden flex-shrink-0">
                    <ImageWithFallback
                      src={assessment.image}
                      alt={assessment.title}
                      className="w-full h-full object-cover"
                    />
                  </div>
                )}

                {/* Assessment Info */}
                <div className="flex-1">
                  <div className="flex items-start justify-between mb-3">
                    <div>
                      <h3 className="text-xl font-semibold mb-1">{assessment.title}</h3>
                      <p className="text-sm text-gray-500">{assessment.subtitle}</p>
                    </div>
                    
                    <div className="flex items-center gap-3">
                      <div className="text-right">
                        <p className="text-sm text-gray-600">Progress</p>
                        <p className="text-lg font-semibold text-emerald-600">{assessment.progress}%</p>
                      </div>
                      <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                        assessment.status === 'Completed'
                          ? 'bg-green-100 text-green-700'
                          : 'bg-blue-100 text-blue-700'
                      }`}>
                        {assessment.status}
                      </span>
                    </div>
                  </div>

                  {/* Tabs */}
                  <div className="flex gap-6 mb-4 border-b border-gray-200">
                    <button className="pb-2 border-b-2 border-emerald-600 text-emerald-600 font-medium text-sm">
                      Unread Trainings
                    </button>
                    <button className="pb-2 text-gray-500 hover:text-gray-700 text-sm">
                      Customize Elixmins
                    </button>
                  </div>

                  {/* Modules */}
                  <div className="space-y-3">
                    {assessment.modules.map((module) => (
                      <div key={module.id} className="flex items-center gap-4">
                        <div className="flex items-center gap-2 w-40">
                          <span className="text-sm text-gray-600">Module {module.id}</span>
                          <ChevronRight className="w-4 h-4 text-gray-400" />
                          <span className="text-sm font-medium">{module.name}</span>
                        </div>
                        
                        <div className="flex-1 flex items-center gap-3">
                          <div className="flex-1 bg-gray-200 rounded-full h-2">
                            <div
                              className="bg-emerald-600 h-2 rounded-full transition-all"
                              style={{ width: `${module.progress}%` }}
                            />
                          </div>
                          <span className="text-sm text-gray-600 w-16">
                            Marks {module.progress}%/101
                          </span>
                        </div>
                      </div>
                    ))}
                  </div>
                </div>
              </div>

              {/* Action Button */}
              <div className="mt-6 flex justify-end">
                <Link
                  to={`/assessments/${assessment.id}`}
                  className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
                >
                  {assessment.status === 'Completed' ? 'Review Assessment' : 'Start Assessment'}
                </Link>
              </div>
            </div>
          </div>
        ))}
      </div>

      {/* Stats Cards */}
      <div className="grid grid-cols-3 gap-6">
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Total Assessments</h3>
            <FileText className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">15</p>
          <p className="text-sm text-gray-500 mt-1">Across all courses</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Completed</h3>
            <Award className="w-5 h-5 text-emerald-600" />
          </div>
          <p className="text-3xl font-semibold">8</p>
          <p className="text-sm text-gray-500 mt-1">53% completion rate</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Average Score</h3>
            <Award className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">87%</p>
          <p className="text-sm text-gray-500 mt-1">Excellent performance</p>
        </div>
      </div>
    </div>
  );
}

function ChevronRight({ className }: { className?: string }) {
  return (
    <svg className={className} fill="none" viewBox="0 0 24 24" stroke="currentColor">
      <path strokeLinecap="round" strokeLinejoin="round" strokeWidth={2} d="M9 5l7 7-7 7" />
    </svg>
  );
}
