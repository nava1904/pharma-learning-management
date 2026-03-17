import { Link } from 'react-router';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Clock, Users } from 'lucide-react';

const courses = [
  {
    id: 'gmp-training',
    title: 'GMP Training',
    description: 'Good Manufacturing Practice (GMP) - Learn the fundamental principles of pharmaceutical manufacturing',
    image: 'https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    duration: '8 hours',
    enrolled: 1250,
    modules: 3,
    progress: 75,
    status: 'In Progress'
  },
  {
    id: 'safety-sop',
    title: 'Safety SOP',
    description: 'Standard Operating Procedures for Laboratory Safety and Compliance',
    image: 'https://images.unsplash.com/photo-1772764331317-4934ee566292?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpY2FsJTIwdHJhaW5pbmclMjBjbGFzc3Jvb218ZW58MXx8fHwxNzczNTIwNjE4fDA&ixlib=rb-4.1.0&q=80&w=1080',
    duration: '6 hours',
    enrolled: 980,
    modules: 4,
    progress: 45,
    status: 'In Progress'
  },
  {
    id: 'quality-control',
    title: 'Quality Control',
    description: 'Quality Control procedures, testing methods, and documentation requirements',
    image: 'https://images.unsplash.com/photo-1576765608689-c0e8f69a46b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMGxhYm9yYXRvcnklMjBzY2llbnRpc3R8ZW58MXx8fHwxNzczNDk5MzUwfDA&ixlib=rb-4.1.0&q=80&w=1080',
    duration: '10 hours',
    enrolled: 1420,
    modules: 5,
    progress: 20,
    status: 'In Progress'
  },
  {
    id: 'regulatory-compliance',
    title: 'Regulatory Compliance',
    description: 'Understanding FDA regulations and pharmaceutical compliance requirements',
    duration: '12 hours',
    enrolled: 890,
    modules: 6,
    progress: 0,
    status: 'Not Started'
  },
  {
    id: 'cleanroom-practices',
    title: 'Cleanroom Practices',
    description: 'Best practices for working in controlled environments and contamination prevention',
    duration: '5 hours',
    enrolled: 1100,
    modules: 3,
    progress: 100,
    status: 'Completed'
  },
  {
    id: 'validation-protocols',
    title: 'Validation Protocols',
    description: 'Process validation, equipment qualification, and validation documentation',
    duration: '9 hours',
    enrolled: 750,
    modules: 4,
    progress: 0,
    status: 'Not Started'
  },
];

export function Courses() {
  return (
    <div className="space-y-6">
      <div className="flex items-center justify-between">
        <div>
          <h1 className="text-2xl font-semibold mb-2">My Courses</h1>
          <p className="text-gray-600">Continue your pharmaceutical training journey</p>
        </div>
        
        <div className="flex gap-2">
          <button className="px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
            All Courses
          </button>
          <button className="px-4 py-2 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors">
            In Progress
          </button>
        </div>
      </div>

      {/* Course Grid */}
      <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        {courses.map((course) => (
          <Link
            key={course.id}
            to={`/courses/${course.id}`}
            className="bg-white rounded-lg border border-gray-200 overflow-hidden hover:shadow-lg transition-shadow"
          >
            {/* Course Image */}
            <div className="aspect-video bg-gray-200 relative overflow-hidden">
              {course.image ? (
                <ImageWithFallback
                  src={course.image}
                  alt={course.title}
                  className="w-full h-full object-cover"
                />
              ) : (
                <div className="w-full h-full bg-gradient-to-br from-emerald-100 to-emerald-200" />
              )}
              
              {/* Status Badge */}
              <div className="absolute top-3 right-3">
                <span className={`px-3 py-1 rounded-full text-xs font-medium ${
                  course.status === 'Completed' 
                    ? 'bg-green-100 text-green-700'
                    : course.status === 'In Progress'
                    ? 'bg-blue-100 text-blue-700'
                    : 'bg-gray-100 text-gray-700'
                }`}>
                  {course.status}
                </span>
              </div>
            </div>

            {/* Course Info */}
            <div className="p-5">
              <h3 className="font-semibold text-lg mb-2">{course.title}</h3>
              <p className="text-sm text-gray-600 mb-4 line-clamp-2">{course.description}</p>
              
              <div className="flex items-center gap-4 text-sm text-gray-500 mb-4">
                <div className="flex items-center gap-1">
                  <Clock className="w-4 h-4" />
                  <span>{course.duration}</span>
                </div>
                <div className="flex items-center gap-1">
                  <Users className="w-4 h-4" />
                  <span>{course.enrolled}</span>
                </div>
              </div>

              {/* Progress Bar */}
              {course.progress > 0 && (
                <div>
                  <div className="flex items-center justify-between text-sm mb-2">
                    <span className="text-gray-600">Progress</span>
                    <span className="font-medium text-emerald-600">{course.progress}%</span>
                  </div>
                  <div className="w-full bg-gray-200 rounded-full h-2">
                    <div 
                      className="bg-emerald-600 h-2 rounded-full transition-all"
                      style={{ width: `${course.progress}%` }}
                    />
                  </div>
                </div>
              )}
            </div>
          </Link>
        ))}
      </div>
    </div>
  );
}
