import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, AreaChart, Area } from 'recharts';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { BookOpen, Award, Target } from 'lucide-react';

const hoursData = [
  { day: '1st', hours: 150 },
  { day: '5th', hours: 180 },
  { day: '10th', hours: 280 },
  { day: '15th', hours: 240 },
  { day: '20th', hours: 260 },
  { day: '25th', hours: 200 },
];

const performanceData = [
  { day: 1, score: 60 },
  { day: 3, score: 55 },
  { day: 5, score: 70 },
  { day: 7, score: 65 },
  { day: 9, score: 75 },
  { day: 11, score: 72 },
  { day: 13, score: 78 },
  { day: 15, score: 80 },
  { day: 17, score: 82 },
  { day: 19, score: 79 },
  { day: 21, score: 85 },
  { day: 23, score: 83 },
  { day: 25, score: 88 },
  { day: 27, score: 86 },
  { day: 29, score: 90 },
];

export function Overview() {
  return (
    <div className="space-y-6">
      {/* Welcome Section */}
      <div className="bg-white rounded-lg p-6 shadow-sm border border-gray-200">
        <div className="flex items-start justify-between">
          <div className="flex-1">
            <h1 className="text-2xl font-semibold mb-2">Hello, Shubham 👋</h1>
            <p className="text-sm text-gray-500">User@transformationlearningtech.com</p>
            
            {/* Stats Cards */}
            <div className="grid grid-cols-3 gap-6 mt-6">
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm text-gray-600">Total Enrolled</span>
                  <div className="w-8 h-8 bg-gray-900 rounded flex items-center justify-center">
                    <BookOpen className="w-4 h-4 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-semibold">5000</p>
              </div>
              
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm text-gray-600">Completed</span>
                  <div className="w-8 h-8 bg-gray-900 rounded flex items-center justify-center">
                    <Award className="w-4 h-4 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-semibold">50</p>
              </div>
              
              <div>
                <div className="flex items-center justify-between mb-2">
                  <span className="text-sm text-gray-600">Quiz Score</span>
                  <div className="w-8 h-8 bg-gray-900 rounded flex items-center justify-center">
                    <Target className="w-4 h-4 text-white" />
                  </div>
                </div>
                <p className="text-3xl font-semibold">30</p>
              </div>
            </div>
          </div>
          
          {/* User Avatar */}
          <div className="text-center">
            <div className="w-20 h-20 rounded-full bg-gray-200 mb-2 overflow-hidden">
              <ImageWithFallback
                src="https://images.unsplash.com/photo-1576765608689-c0e8f69a46b2?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMGxhYm9yYXRvcnklMjBzY2llbnRpc3R8ZW58MXx8fHwxNzczNDk5MzUwfDA&ixlib=rb-4.1.0&q=80&w=1080"
                alt="User"
                className="w-full h-full object-cover"
              />
            </div>
            <p className="font-medium">Shubham Yadav</p>
            <p className="text-sm text-gray-500">College Student</p>
          </div>
        </div>
      </div>

      {/* Charts Section */}
      <div className="grid grid-cols-2 gap-6">
        {/* Hours Spent Chart */}
        <div className="bg-white rounded-lg p-6 shadow-sm border border-gray-200">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-lg font-semibold">Hours Spent</h2>
            <button className="text-sm text-emerald-600 hover:text-emerald-700">
              Latest 7 Days
            </button>
          </div>
          
          <ResponsiveContainer width="100%" height={250}>
            <BarChart data={hoursData}>
              <CartesianGrid strokeDasharray="3 3" vertical={false} />
              <XAxis dataKey="day" axisLine={false} tickLine={false} />
              <YAxis axisLine={false} tickLine={false} />
              <Tooltip />
              <Bar dataKey="hours" fill="#10b981" radius={[8, 8, 0, 0]} />
            </BarChart>
          </ResponsiveContainer>
        </div>

        {/* Performance Chart */}
        <div className="bg-white rounded-lg p-6 shadow-sm border border-gray-200">
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-lg font-semibold">Performance</h2>
            <button className="text-sm text-emerald-600 hover:text-emerald-700">
              XY
            </button>
          </div>
          
          <div className="grid grid-cols-3 gap-4 mb-4">
            <div>
              <p className="text-sm text-gray-600">Total Hours</p>
              <p className="text-2xl font-semibold">70,468</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Avg. Score</p>
              <p className="text-2xl font-semibold">82%</p>
            </div>
            <div>
              <p className="text-sm text-gray-600">Courses</p>
              <p className="text-2xl font-semibold">30</p>
            </div>
          </div>
          
          <ResponsiveContainer width="100%" height={150}>
            <AreaChart data={performanceData}>
              <defs>
                <linearGradient id="colorScore" x1="0" y1="0" x2="0" y2="1">
                  <stop offset="5%" stopColor="#10b981" stopOpacity={0.3}/>
                  <stop offset="95%" stopColor="#10b981" stopOpacity={0}/>
                </linearGradient>
              </defs>
              <CartesianGrid strokeDasharray="3 3" vertical={false} />
              <XAxis dataKey="day" hide />
              <YAxis hide />
              <Tooltip />
              <Area type="monotone" dataKey="score" stroke="#10b981" fill="url(#colorScore)" strokeWidth={2} />
            </AreaChart>
          </ResponsiveContainer>
        </div>
      </div>

      {/* Recent Courses */}
      <div className="bg-white rounded-lg p-6 shadow-sm border border-gray-200">
        <h2 className="text-lg font-semibold mb-4">Continue Learning</h2>
        <div className="grid grid-cols-3 gap-4">
          <div className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="aspect-video bg-gray-200 rounded-lg mb-3 overflow-hidden">
              <ImageWithFallback
                src="https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080"
                alt="GMP Training"
                className="w-full h-full object-cover"
              />
            </div>
            <h3 className="font-semibold mb-1">GMP Training</h3>
            <p className="text-sm text-gray-500 mb-2">Good Manufacturing Practice</p>
            <div className="flex items-center justify-between text-sm">
              <span className="text-gray-600">Progress: 75%</span>
              <span className="text-emerald-600 font-medium">Continue</span>
            </div>
          </div>
          
          <div className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="aspect-video bg-gray-200 rounded-lg mb-3 overflow-hidden">
              <ImageWithFallback
                src="https://images.unsplash.com/photo-1772764331317-4934ee566292?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxtZWRpY2FsJTIwdHJhaW5pbmclMjBjbGFzc3Jvb218ZW58MXx8fHwxNzczNTIwNjE4fDA&ixlib=rb-4.1.0&q=80&w=1080"
                alt="Safety SOP"
                className="w-full h-full object-cover"
              />
            </div>
            <h3 className="font-semibold mb-1">Safety SOP</h3>
            <p className="text-sm text-gray-500 mb-2">Standard Operating Procedures</p>
            <div className="flex items-center justify-between text-sm">
              <span className="text-gray-600">Progress: 45%</span>
              <span className="text-emerald-600 font-medium">Continue</span>
            </div>
          </div>
          
          <div className="border border-gray-200 rounded-lg p-4 hover:shadow-md transition-shadow cursor-pointer">
            <div className="aspect-video bg-gray-200 rounded-lg mb-3"></div>
            <h3 className="font-semibold mb-1">Quality Control</h3>
            <p className="text-sm text-gray-500 mb-2">QC Procedures & Testing</p>
            <div className="flex items-center justify-between text-sm">
              <span className="text-gray-600">Progress: 20%</span>
              <span className="text-emerald-600 font-medium">Continue</span>
            </div>
          </div>
        </div>
      </div>
    </div>
  );
}
