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
    title: 'Serenova',
    image: {
      src: '/static/images/5.webp',
      width: 600,
      height: 554,
    },
  },
  {
    description: 'I built',
    title: 'SunSeer',
    image: {
      src: '/static/images/4.webp',
      width: 600,
      height: 554,
    },
  },
  {
    description: 'I started',
    title: 'Blogging on Medium',
    image: {
      src: '/static/images/3.webp',
      width: 600,
      height: 717,
    },
  },
]
