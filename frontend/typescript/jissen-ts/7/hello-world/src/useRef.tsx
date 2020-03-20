import React, { useRef, useEffect } from "react"
/* 従来、refを用いたDOM要素アクセスはReact.Componentなどのクラスコンポーネントのみで可能でした。
 * useRefを利用するとFucntion ComponentでもDOM要素にアクセスできます。
 *
 * このコンポーネントがマウントされた行がされるまではrefを参照できません。そのため、このユースケースの場合は必ず null | HTMLDivElementのような方の付与が必要である、初期値はnullになります。
*/

export const Component: React.FC = () => {
  const ref = useRef<null | HTMLDivElement>(null)
  useEffect(() => {
    if (ref.current === null) return
    const size = ref.current.getBoundingClientRect()
    console.log({ size: size })
  })
  return (
    <div>
      <div ref={ref} style={{ width: 100, height: 100 }}></div>
    </div>
  )
}
