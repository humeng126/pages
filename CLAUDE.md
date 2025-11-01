# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a static website collection of personal growth and philosophical articles written in Chinese. The project contains 107+ HTML files organized into thematic categories covering topics like philosophy, psychology, self-improvement, and traditional wisdom.

## Repository Structure

### Content Organization

- **Numbered folders (1-7)**: Main philosophical themes
  - `1.牧言` (7 files) - Personal wisdom and teachings
  - `2.了凡四训` (9 files) - Classical Chinese wisdom teachings
  - `3.心经` (3 files) - Heart Sutra Buddhist philosophy
  - `4.道德经` (1 file) - Tao Te Ching
  - `5.庄子` (6 files) - Zhuangzi philosophy
  - `6.阳明心学` (2 files) - Wang Yangming's philosophy
  - `7.李二八` (8 files) - Modern practical wisdom

- **其它 folder**: Miscellaneous topics with 8 subcategories
  - `1.学习方法` (8 files) - Learning methods
  - `2.技能提升` (2 files) - Skill development
  - `3.心理健康` (19 files) - Mental health and psychology
  - `4.经验总结` (16 files) - Life experience summaries
  - `5.表达能力` (4 files) - Communication skills
  - `6.工作方法` (6 files) - Work methodologies
  - `7.访谈` (2 files) - Interviews
  - `8.两性与情感` (3 files) - Relationships

### Key Files

- `index.html` - Main navigation page with modern web design
- `file_counter.ps1` - PowerShell script for content statistics
- `文件统计结果.txt` - Generated statistics report

## Technical Architecture

### HTML File Structure
Each HTML file follows a consistent pattern:
- Modern responsive design using Tailwind CSS
- Interactive animations and JavaScript enhancements
- Chinese content with sophisticated typography
- Mobile-responsive layouts with CSS Grid/Flexbox
- Smooth scrolling and intersection observer animations

### CSS Framework
- **Tailwind CSS** via CDN for utility-first styling
- Custom color schemes with gradient backgrounds
- Responsive breakpoints: mobile (480px), tablet (768px), desktop (1200px)
- CSS Grid for complex layouts (bento-grid system)

### JavaScript Features
- Intersection Observer API for scroll animations
- Dynamic progress bars and interactive elements
- Smooth scrolling navigation
- Mobile menu functionality
- Wave animations and visual effects

## Common Operations

### Adding New Articles

1. Create new HTML file in appropriate category folder
2. Follow existing naming pattern: `序号.标题.html`
3. Use existing template structure from other articles
4. Update `index.html` to include new article link
5. Run statistics script to update counts

### Content Management

```bash
# Generate file statistics (PowerShell)
.\file_counter.ps1

# View statistics report
cat 文件统计结果.txt
```

### Publishing

The repository automatically deploys to GitHub Pages via the `.github/workflows/static.yml` workflow:
- Triggers on push to main branch
- Deploys entire repository as static site
- Updates live site automatically

## Development Guidelines

### File Naming
- Use Chinese titles in filenames
- Maintain numerical ordering within categories
- Keep filenames descriptive but concise
- Use proper HTML encoding for special characters

### Content Structure
Each article should include:
- Semantic HTML5 structure
- Responsive navigation
- Mobile-first design approach
- Consistent typography and color schemes
- Accessibility considerations (ARIA labels, semantic markup)

### CSS Guidelines
- Use Tailwind utility classes primarily
- Custom CSS for complex animations only
- Maintain consistent color palette
- Ensure mobile responsiveness
- Use CSS Grid for complex layouts

### Performance Considerations
- External CDN resources (Tailwind, Font Awesome, Framer Motion)
- Optimized images and media
- Minimal JavaScript for enhanced UX
- Lazy loading for large content sections

## Quality Assurance

### Testing
- Test on multiple screen sizes (mobile, tablet, desktop)
- Verify all navigation links work properly
- Check Chinese character rendering
- Validate HTML structure

### Content Review
- Ensure proper categorization
- Verify index.html links are updated
- Check file naming consistency
- Review content organization

## Deployment

The site is configured for automatic deployment to GitHub Pages. No manual build process required - simply push changes to the main branch and the workflow will handle deployment.

## 提示词
请你根据目录及里面内容更新index.html 