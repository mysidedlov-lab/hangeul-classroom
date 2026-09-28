# 한글 한 걸음 교실

초등학교 2학년 기초 문해력 보정학습을 위한 Next.js 기반 웹앱입니다. 교사용 대시보드, 학생 학급 코드/PIN 입장, 10차시 학습, 진도·오류 분석, CSV 내보내기를 포함합니다.

## 바로 실행

```bash
npm install
npm run dev
```

`http://localhost:3000`에서 실행됩니다. 환경 변수가 없으면 브라우저 저장소를 사용하는 데모 모드로 동작합니다.

체험용 학생 정보:

- 학급 코드: `가람-2741`
- 학생: `햇살 1번`
- PIN: `1234`

## Supabase 연결

1. Supabase 프로젝트를 생성합니다.
2. `supabase/migrations/001_initial.sql`을 SQL Editor에서 실행합니다.
3. Authentication → Providers에서 Google을 활성화합니다.
4. `.env.example`을 `.env.local`로 복사하고 값을 입력합니다.
5. 학생 PIN 검증과 학습 기록 저장은 서버 Route Handler에서 service role key를 사용하도록 연결합니다. service role key는 절대 `NEXT_PUBLIC_` 변수로 만들지 않습니다.

## Vercel 배포

1. 이 폴더를 GitHub 저장소에 올립니다.
2. Vercel에서 저장소를 Import합니다.
3. Supabase 환경 변수를 Vercel Project Settings에 등록합니다.
4. Supabase Google OAuth Redirect URL에 Vercel 배포 주소를 추가합니다.
5. 배포 후 교사 계정으로 로그인해 학급과 학생을 생성합니다.

## 개인정보 원칙

- 학생 이메일, 전화번호, 생년월일을 수집하지 않습니다.
- 별칭 사용을 권장합니다.
- PIN은 해시로만 저장합니다.
- RLS 정책으로 교사는 자신의 학급 데이터만 열람합니다.
- 학생 로그인 API에는 시도 횟수 제한을 추가해 운영하세요.
