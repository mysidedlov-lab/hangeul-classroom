import type { Metadata } from "next";
import "./globals.css";

export const metadata: Metadata = {
  title: "한글 한 걸음 교실",
  description: "초등학교 2학년 기초 문해력 보정학습 플랫폼",
};

export default function RootLayout({children}:{children:React.ReactNode}) {
  return <html lang="ko"><body>{children}</body></html>;
}
