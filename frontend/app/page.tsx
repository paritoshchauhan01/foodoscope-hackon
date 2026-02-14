'use client'

import { useRouter } from 'next/navigation'
import LoginForm from '@/components/LoginForm'
import Button from '@/components/ui/Button'
import { api } from '@/lib/api'

export default function HomePage() {
  const router = useRouter()

  const handleDemo = async () => {
    try {
      const data = await api.demoLogin()
      localStorage.setItem('token', data.token)
      localStorage.setItem('user', JSON.stringify(data.user))
      router.push('/onboarding')
    } catch (error) {
      console.error('Demo login failed:', error)
      alert('Demo login failed')
    }
  }

  return (
    <div className="min-h-screen flex items-center justify-center bg-gray-50 py-12">
      <div className="container max-w-3xl">
        <div className="grid md:grid-cols-2 gap-8 items-center">
          <div>
            <h1 className="text-4xl font-bold mb-4">NutriContext</h1>
            <p className="text-gray-600 mb-6">Find recipes personalized to your dietary needs and local context.</p>
            <Button onClick={() => router.push('/onboarding')} className="mr-3">Get Started</Button>
            <Button variant="secondary" onClick={handleDemo}>Try Demo</Button>
          </div>

          <div className="card p-8">
            <h2 className="text-2xl font-bold mb-4">Sign in</h2>
            <LoginForm />
          </div>
        </div>
      </div>
    </div>
  )
}
