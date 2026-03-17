import { FolderKanban, Plus, Clock, Users } from 'lucide-react';

const projects = [
  {
    id: 1,
    title: 'GMP Implementation Plan',
    description: 'Develop a comprehensive GMP implementation strategy for a new facility',
    status: 'in-progress',
    dueDate: 'March 25, 2026',
    progress: 60,
    members: 4
  },
  {
    id: 2,
    title: 'Safety Protocol Review',
    description: 'Review and update current safety procedures based on new regulations',
    status: 'in-progress',
    dueDate: 'March 30, 2026',
    progress: 35,
    members: 3
  },
  {
    id: 3,
    title: 'Quality Control Case Study',
    description: 'Analyze a real-world QC scenario and propose improvements',
    status: 'completed',
    completedDate: 'March 1, 2026',
    progress: 100,
    members: 2
  },
  {
    id: 4,
    title: 'Validation Documentation',
    description: 'Create validation documentation for equipment qualification',
    status: 'not-started',
    dueDate: 'April 10, 2026',
    progress: 0,
    members: 1
  }
];

export function Project() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold mb-2">Projects</h1>
          <p className="text-gray-600">Apply your knowledge to real-world scenarios</p>
        </div>
        
        <button className="flex items-center gap-2 px-4 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
          <Plus className="w-5 h-5" />
          New Project
        </button>
      </div>

      {/* Stats */}
      <div className="grid grid-cols-4 gap-6">
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Total Projects</h3>
            <FolderKanban className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">4</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">In Progress</h3>
            <FolderKanban className="w-5 h-5 text-blue-600" />
          </div>
          <p className="text-3xl font-semibold">2</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Completed</h3>
            <FolderKanban className="w-5 h-5 text-emerald-600" />
          </div>
          <p className="text-3xl font-semibold">1</p>
        </div>
        
        <div className="bg-white rounded-lg border border-gray-200 p-6">
          <div className="flex items-center justify-between mb-2">
            <h3 className="text-sm text-gray-600">Not Started</h3>
            <FolderKanban className="w-5 h-5 text-gray-400" />
          </div>
          <p className="text-3xl font-semibold">1</p>
        </div>
      </div>

      {/* Projects Grid */}
      <div className="grid grid-cols-2 gap-6">
        {projects.map((project) => (
          <div
            key={project.id}
            className="bg-white rounded-lg border border-gray-200 p-6 hover:shadow-md transition-shadow cursor-pointer"
          >
            <div className="flex items-start justify-between mb-4">
              <div className="flex-1">
                <h3 className="text-lg font-semibold mb-2">{project.title}</h3>
                <p className="text-sm text-gray-600">{project.description}</p>
              </div>
              
              <span
                className={`px-3 py-1 rounded-full text-xs font-medium flex-shrink-0 ml-4 ${
                  project.status === 'completed'
                    ? 'bg-green-100 text-green-700'
                    : project.status === 'in-progress'
                    ? 'bg-blue-100 text-blue-700'
                    : 'bg-gray-100 text-gray-700'
                }`}
              >
                {project.status === 'completed'
                  ? 'Completed'
                  : project.status === 'in-progress'
                  ? 'In Progress'
                  : 'Not Started'}
              </span>
            </div>

            {/* Progress Bar */}
            {project.progress > 0 && (
              <div className="mb-4">
                <div className="flex items-center justify-between text-sm mb-2">
                  <span className="text-gray-600">Progress</span>
                  <span className="font-medium text-emerald-600">{project.progress}%</span>
                </div>
                <div className="w-full bg-gray-200 rounded-full h-2">
                  <div
                    className="bg-emerald-600 h-2 rounded-full transition-all"
                    style={{ width: `${project.progress}%` }}
                  />
                </div>
              </div>
            )}

            {/* Meta Info */}
            <div className="flex items-center justify-between text-sm text-gray-600 pt-4 border-t border-gray-200">
              <div className="flex items-center gap-1">
                <Clock className="w-4 h-4" />
                <span>
                  {project.status === 'completed'
                    ? `Completed ${project.completedDate}`
                    : `Due ${project.dueDate}`}
                </span>
              </div>
              <div className="flex items-center gap-1">
                <Users className="w-4 h-4" />
                <span>{project.members} member{project.members !== 1 ? 's' : ''}</span>
              </div>
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}
