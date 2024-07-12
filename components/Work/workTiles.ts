export type WorkTile = {
  title: string
  description: string
  image: {
    src: string
    width: number
    height: number
  }
}

export const workTiles: WorkTile[] = [
  {
    description: '',
    title: 'Tech Stack',
    image: {
      src: '/static/images/skills.png',
      width: 600,
      height: 554,
    },
  },
  {
    description: `Here is`,
    title: `what I've been up to`,
    image: {
      src: '/static/images/1.webp',
      width: 600,
      height: 770,
    },
  },
  {
    description: 'I built',
    title: 'Vitalize',
    image: {
      src: '/static/images/5.gif',
      width: 600,
      height: 554,
    },
  },
  {
    description: 'I built',
    title: 'UniRide',
    image: {
      src: '/static/images/4.gif',
      width: 600,
      height: 554,
    },
  },
]
