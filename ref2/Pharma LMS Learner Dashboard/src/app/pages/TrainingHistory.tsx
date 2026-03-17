import { Link } from 'react-router';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { ChevronLeft, FileDown } from 'lucide-react';

const historyData = [
  {
    id: 1,
    name: 'GMP Training',
    image: 'https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    enrolled: '03/03/2025',
    completed: '02.25/12/2021',
    score: 'Mid-Finished 102/105',
    status: 'Mid-finished'
  },
  {
    id: 2,
    name: 'Safety SOP',
    image: 'https://images.unsplash.com/photo-1772764331317-4934ee566292?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpY2FsJTIwdHJhaW5pbmclMjBjbGFzc3Jvb218ZW58MXx8fHwxNzczNTIwNjE4fDA&ixlib=rb-4.1.0&q=80&w=1080',
    enrolled: '01.23.2025',
    completed: '01.16/12/2021',
    score: 'Mid-Examined 18/24',
    status: 'Mid-finished'
  },
  {
    id: 3,
    name: 'Quality Control',
    image: 'https://images.unsplash.com/photo-1576765608689-c0e8f69a46b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMGxhYm9yYXRvcnklMjBzY2llbnRpc3R8ZW58MXx8fHwxNzczNDk5MzUwfDA&ixlib=rb-4.1.0&q=80&w=1080',
    enrolled: '01.23.2025',
    completed: '01.10/12/2025',
    score: 'Mid-Examined 18/24',
    status: 'Mid-finished'
  }
];

export function TrainingHistory() {
  return (
    <div className="max-w-6xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/assessments" className="p-2 hover:bg-gray-100 rounded-lg">
            <ChevronLeft className="w-5 h-5" />
          </Link>
          <div>
            <h1 className="text-2xl font-semibold">Training History</h1>
          </div>
        </div>
        
        <button className="flex items-center gap-2 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
          <FileDown className="w-4 h-4" />
          Download PDF
        </button>
      </div>

      {/* Tabs */}
      <div className="flex gap-6 border-b border-gray-200">
        <button className="pb-3 border-b-2 border-emerald-600 text-emerald-600 font-medium">
          Sportham Engpt
        </button>
        <button className="pb-3 text-gray-500 hover:text-gray-700">
          Hcedent Recently
        </button>
        <button className="pb-3 text-gray-500 hover:text-gray-700">
          Courses
        </button>
        <button className="pb-3 text-gray-500 hover:text-gray-700">
          Sendicer
        </button>
        <button className="pb-3 text-gray-500 hover:text-gray-700">
          Suscides
        </button>
      </div>

      {/* Table */}
      <div className="bg-white rounded-lg border border-gray-200">
        {/* Table Header */}
        <div className="grid grid-cols-12 gap-4 p-4 border-b border-gray-200 text-sm text-gray-600 font-medium">
          <div className="col-span-1">Marks</div>
          <div className="col-span-1"></div>
          <div className="col-span-3">Course</div>
          <div className="col-span-2">Registered</div>
          <div className="col-span-2">Rasterterased 97</div>
          <div className="col-span-2">Courses</div>
          <div className="col-span-1"></div>
        </div>

        {/* Table Rows */}
        {historyData.map((item) => (
          <div key={item.id} className="grid grid-cols-12 gap-4 p-4 border-b border-gray-200 hover:bg-gray-50 items-center">
            <div className="col-span-1 text-sm text-gray-600">{item.id}</div>
            <div className="col-span-1">
              <div className="w-10 h-10 bg-gray-200 rounded-full overflow-hidden">
                <ImageWithFallback
                  src={item.image}
                  alt={item.name}
                  className="w-full h-full object-cover"
                />
              </div>
            </div>
            <div className="col-span-3">
              <h3 className="font-semibold">{item.name}</h3>
            </div>
            <div className="col-span-2 text-sm">{item.enrolled}</div>
            <div className="col-span-2 text-sm">{item.completed}</div>
            <div className="col-span-2">
              <span className="px-2 py-1 bg-emerald-100 text-emerald-700 rounded text-xs font-medium">
                {item.status}
              </span>
            </div>
            <div className="col-span-1 text-right">
              <button className="text-gray-400 hover:text-gray-600">
                <span className="text-xl">›</span>
              </button>
            </div>
          </div>
        ))}
      </div>

      {/* Action Buttons */}
      <div className="flex items-center justify-between">
        <Link
          to="/assessments"
          className="flex items-center gap-2 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors"
        >
          <ChevronLeft className="w-4 h-4" />
          Previous Lesson
        </Link>
        
        <button className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
          Marsh Lesson
        </button>
      </div>
    </div>
  );
}
