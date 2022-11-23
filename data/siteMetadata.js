const siteMetadata = {
  title: 'Jaivardhan Bhola',
  author: 'Jaivardhan Bhola',
  headerTitle: 'dalelarroder',
  description: 'Software Engineer at Aphex',
  language: 'en-us',
  theme: 'dark', // system, dark or light
  siteUrl: 'https://dalelarroder.com',
  siteRepo: 'https://github.com/jaivardhan-bhola/portfolio',
  siteLogo: '/static/images/logo.png',
  image: '/static/images/avatar.webp',
  email: 'jaivardhan.bhola@gmail.com',  
  socialBanner: '/static/images/twitter-card.png',
  github: 'https://github.com/jaivardhan-bhola',
  twitter: 'https://twitter.com/BholaJaivardhan',
  linkedin: 'https://www.linkedin.com/in/jaivardhan-bhola-773944214/',
  spotify: 'https://open.spotify.com/user/31n5rvtsqztcplhxx7jqw44g2gy4?si=1f79fc8cce5e45bb',
  medium: 'https://medium.com/@jaivardhan.bhola',
  discord: 'https://discord.com/users/1042847574417231902',
  instagram: 'https://www.instagram.com/jaivardhan_b/',
  locale: 'en-US',
  comment: {
    provider: 'giscus',
    giscusConfig: {
      repo: process.env.NEXT_PUBLIC_GISCUS_REPO || '',
      repositoryId: process.env.NEXT_PUBLIC_GISCUS_REPOSITORY_ID || '',
      category: process.env.NEXT_PUBLIC_GISCUS_CATEGORY || '',
      categoryId: process.env.NEXT_PUBLIC_GISCUS_CATEGORY_ID || '',
      mapping: 'pathname',
      reactions: '1',
      metadata: '0',
      theme: 'light',
      darkTheme: 'transparent_dark',
      themeURL: '',
    },
  },
}

module.exports = siteMetadata
