import { useState, useEffect } from 'react';
import { useParams, Link } from 'react-router';
import { ImageWithFallback } from '../components/figma/ImageWithFallback';
import { Clock, ChevronLeft, CheckCircle2 } from 'lucide-react';

const assessmentData = {
  'gmp-compliance-quiz': {
    title: 'GMP Compliance Quiz',
    subtitle: 'Expert Required for Compliance Topics',
    image: 'https://images.unsplash.com/photo-1757578097654-fdae0f7cf008?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w3Nzg4Nzd8MHwxfHNlYXJjaHwxfHxwaGFybWFjZXV0aWNhbCUyMG1hbnVmYWN0dXJpbmclMjBmYWNpbGl0eXxlbnwxfHx8fDE3NzM0NzEzMTh8MA&ixlib=rb-4.1.0&q=80&w=1080',
    courses: [
      {
        id: 1,
        name: 'GMP Training',
        description: 'Lorem ipsum sharpens drug GMP & max prep cured contamination developing standard pharmaceutical industry business GMP/FDA 01 00 (P) SB $1 ert med lsr s-me tars s GMP ne s',
        enrolled: '2S/03/2025',
        score: 85,
        status: 'Members',
        badge: 'Mid-finished'
      },
      {
        id: 2,
        name: 'Safety SOP',
        enrolled: '01/01/2021',
        score: 93,
        status: 'Members',
        badge: 'Mid-finished'
      },
      {
        id: 3,
        name: 'Quality Control',
        enrolled: '01/01/2025',
        score: 94,
        status: 'Members',
        badge: 'Mid-finished'
      }
    ],
    questions: [
      {
        id: 1,
        text: 'Lorem irolk leek measured arctic endomitis eros charrodus orm diarany ororom -ssolis dimir gramicizing oja quet is smart oferej parented tegmen ossit mortes',
        options: [
          { id: 'a', text: 'Generationram Sarca' },
          { id: 'b', text: 'Recommentocuri secretis, woties ait e g consilitis pronto. Tellma moritis.' },
          { id: 'c', text: 'Nulla quis stenderd arcu, venenatis vort e telibus posuere eo-cutem egest rit' }
        ]
      }
    ]
  }
};

export function AssessmentStart() {
  const { id } = useParams();
  const assessment = assessmentData[id as keyof typeof assessmentData];
  const [timeLeft, setTimeLeft] = useState(8 * 60 + 23); // 8:23 in seconds
  const [view, setView] = useState<'overview' | 'test'>('overview');

  useEffect(() => {
    if (view === 'test') {
      const timer = setInterval(() => {
        setTimeLeft((prev) => (prev > 0 ? prev - 1 : 0));
      }, 1000);
      return () => clearInterval(timer);
    }
  }, [view]);

  const formatTime = (seconds: number) => {
    const mins = Math.floor(seconds / 60);
    const secs = seconds % 60;
    return `${mins.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
  };

  if (!assessment) {
    return <div>Assessment not found</div>;
  }

  if (view === 'test') {
    return (
      <div className="max-w-4xl mx-auto space-y-6">
        {/* Header */}
        <div className="flex items-center justify-between">
          <div className="flex items-center gap-4">
            <Link to="/assessments" className="p-2 hover:bg-gray-100 rounded-lg">
              <ChevronLeft className="w-5 h-5" />
            </Link>
            <div>
              <h1 className="text-2xl font-semibold">Assessment Start</h1>
              <p className="text-sm text-gray-600">{assessment.title}</p>
            </div>
          </div>
          
          <div className="flex items-center gap-4">
            <div className="text-right">
              <p className="text-sm text-gray-600">Assessment Q:8/23</p>
              <p className="text-sm text-emerald-600">Recent Start 9</p>
            </div>
            <button className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
              Exam Lesson
            </button>
          </div>
        </div>

        {/* Assessment Content */}
        <div className="bg-white rounded-lg border border-gray-200 p-8">
          <div className="flex items-center gap-4 mb-6">
            <Link to="/assessments" className="text-gray-600 hover:text-gray-900">
              <ChevronLeft className="w-5 h-5" />
            </Link>
            <h2 className="text-xl font-semibold">Headroom & Exercises</h2>
          </div>

          {/* Timer */}
          <div className="flex justify-end mb-8">
            <div className="flex items-center justify-center w-32 h-32 rounded-full border-4 border-amber-400">
              <div className="text-center">
                <p className="text-3xl font-semibold">{formatTime(timeLeft)}</p>
              </div>
            </div>
          </div>

          {/* Question */}
          <div className="space-y-6">
            <div className="space-y-4">
              <div className="flex items-start gap-3">
                <div className="w-6 h-6 rounded-full bg-gray-900 text-white flex items-center justify-center flex-shrink-0 text-sm font-medium">
                  1
                </div>
                <p className="text-gray-700 leading-relaxed">
                  {assessment.questions[0].text}
                </p>
              </div>

              <div className="ml-9 space-y-3">
                {assessment.questions[0].options.map((option) => (
                  <label key={option.id} className="flex items-start gap-3 p-4 border border-gray-200 rounded-lg hover:bg-gray-50 cursor-pointer">
                    <input type="checkbox" className="mt-1" />
                    <div>
                      <p className="font-medium mb-1">Name : Generationram Sarca</p>
                      <p className="text-sm text-gray-600">{option.text}</p>
                    </div>
                    <span className="ml-auto text-sm text-gray-500">Start = 02.23.2025</span>
                  </label>
                ))}
              </div>
            </div>
          </div>

          {/* Navigation */}
          <div className="flex items-center justify-between mt-8 pt-6 border-t border-gray-200">
            <button className="flex items-center gap-2 px-4 py-2 border border-gray-300 rounded-lg hover:bg-gray-50 transition-colors">
              <ChevronLeft className="w-4 h-4" />
              Previous Lesson
            </button>
            
            <button className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
              Next Exercise
            </button>
          </div>
        </div>
      </div>
    );
  }

  return (
    <div className="max-w-5xl mx-auto space-y-6">
      {/* Header */}
      <div className="flex items-center justify-between">
        <div className="flex items-center gap-4">
          <Link to="/assessments" className="p-2 hover:bg-gray-100 rounded-lg">
            <ChevronLeft className="w-5 h-5" />
          </Link>
          <div>
            <h1 className="text-2xl font-semibold">Assessment Start</h1>
            <p className="text-sm text-gray-600">{assessment.title}</p>
          </div>
        </div>
        
        <div className="flex items-center gap-4">
          <div className="text-right">
            <p className="text-sm text-gray-600">Assessment Q:8/23</p>
            <p className="text-sm text-emerald-600">Recent Start 9</p>
          </div>
          <button className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium">
            Exam Lesson
          </button>
        </div>
      </div>

      {/* Tabs */}
      <div className="flex gap-6 border-b border-gray-200">
        <button className="pb-3 border-b-2 border-emerald-600 text-emerald-600 font-medium">
          Headroom & Exercises
        </button>
        <button className="pb-3 text-gray-500 hover:text-gray-700">
          Gaurex Elimin
        </button>
      </div>

      {/* Course List */}
      <div className="bg-white rounded-lg border border-gray-200">
        {/* Table Header */}
        <div className="grid grid-cols-12 gap-4 p-4 border-b border-gray-200 text-sm text-gray-600 font-medium">
          <div className="col-span-1"></div>
          <div className="col-span-1"></div>
          <div className="col-span-4">Course</div>
          <div className="col-span-2">Enrolled</div>
          <div className="col-span-1">Score</div>
          <div className="col-span-2">Status</div>
          <div className="col-span-1">Routs</div>
        </div>

        {/* Table Rows */}
        {assessment.courses.map((course) => (
          <div key={course.id} className="grid grid-cols-12 gap-4 p-4 border-b border-gray-200 hover:bg-gray-50 items-center">
            <div className="col-span-1">
              <input type="checkbox" className="rounded" />
            </div>
            <div className="col-span-1">
              <div className="w-10 h-10 bg-gray-200 rounded-full overflow-hidden">
                <ImageWithFallback
                  src={assessment.image}
                  alt={course.name}
                  className="w-full h-full object-cover"
                />
              </div>
            </div>
            <div className="col-span-4">
              <h3 className="font-semibold mb-1">{course.name}</h3>
              {course.description && (
                <p className="text-sm text-gray-500 line-clamp-1">{course.description}</p>
              )}
            </div>
            <div className="col-span-2 text-sm">{course.enrolled}</div>
            <div className="col-span-1 text-sm">{course.score}D</div>
            <div className="col-span-2 text-sm">{course.status}</div>
            <div className="col-span-1">
              <span className="px-2 py-1 bg-emerald-100 text-emerald-700 rounded text-xs font-medium">
                {course.badge}
              </span>
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
        
        <button
          onClick={() => setView('test')}
          className="px-6 py-2.5 bg-emerald-600 text-white rounded-lg hover:bg-emerald-700 transition-colors font-medium"
        >
          Start Lesson
        </button>
      </div>
    </div>
  );
}