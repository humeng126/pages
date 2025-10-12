# 设置编码为UTF-8支持中文
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$PSDefaultParameterValues['Out-File:Encoding'] = 'utf8'

# 定义文件夹路径
$folderPath = "D:\project\y_project\pages"

# 检查文件夹是否存在
if (-not (Test-Path $folderPath)) {
    Write-Host "错误: 文件夹 '$folderPath' 不存在！" -ForegroundColor Red
    exit
}

# 初始化结果哈希表
$foldersByNumber = @{}
$foldersByOther = @{}

# 递归读取所有文件夹
$allFolders = Get-ChildItem -Path $folderPath -Directory -Recurse

# 分类文件夹
foreach ($folder in $allFolders) {
    $folderName = $folder.Name
    $relativePath = $folder.FullName.Replace($folderPath + "\", "")
    
    # 跳过以.开头的文件夹
    if ($folderName -match '^\.' -or $relativePath -match '^\.' -or $relativePath -match '\\.') {
        continue
    }
    
    if ($folderName -match '^[0-9]') {
        $foldersByNumber[$relativePath] = @()
    }
    else {
        $foldersByOther[$relativePath] = @()
    }
}

# 递归读取文件夹中的所有文件（包含子文件夹）
$allFiles = Get-ChildItem -Path $folderPath -File -Recurse

# 遍历文件，分类到对应的文件夹
foreach ($file in $allFiles) {
    $relativePath = $file.FullName.Replace($folderPath + "\", "")
    $parentPath = Split-Path $relativePath -Parent
    
    if ([string]::IsNullOrEmpty($parentPath)) {
        continue
    }
    
    $fileName = $file.Name
    $fileSize = [math]::Round($file.Length / 1KB, 2)
    $fileInfo = "$fileName (大小: $fileSize KB)"
    
    # 跳过隐藏文件和特殊文件夹（以.开头的文件或文件夹）
    if ($fileName -match '^\.' -or $parentPath -match '^\.' -or $parentPath -match '\\\.') {
        continue
    }
    
    # 跳过根路径下的文件（除了数字开头的文件夹）
    if ($parentPath.Split('\').Count -eq 1 -and $parentPath -notmatch '^[0-9]' -and $parentPath -ne "其它") {
        continue
    }
    
    # 按照父文件夹分类
    if ($parentPath -match '^[0-9]') {
        if (-not $foldersByNumber.ContainsKey($parentPath)) {
            $foldersByNumber[$parentPath] = @()
        }
        $foldersByNumber[$parentPath] += $fileInfo
    }
    else {
        if (-not $foldersByOther.ContainsKey($parentPath)) {
            $foldersByOther[$parentPath] = @()
        }
        $foldersByOther[$parentPath] += $fileInfo
    }
}

# 输出结果
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "文件夹及文件统计结果" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan
Write-Host ""

# 输出数字开头的文件夹详情
Write-Host "【数字开头的文件夹及其文件】 (共 $($foldersByNumber.Count) 个文件夹)" -ForegroundColor Magenta
Write-Host "---" -ForegroundColor Magenta
if ($foldersByNumber.Count -eq 0) {
    Write-Host "  (没有找到数字开头的文件夹)"
}
else {
    $totalFilesInNumber = 0
    $foldersByNumber.Keys | Sort-Object | ForEach-Object {
        if ($foldersByNumber[$_].Count -gt 0) {
            Write-Host "  📁 $_" -ForegroundColor Magenta
            $totalFilesInNumber += $foldersByNumber[$_].Count
            $foldersByNumber[$_] | ForEach-Object {
                Write-Host "     ├─ $_"
            }
        }
    }
    if ($totalFilesInNumber -gt 0) {
        Write-Host "  数字开头文件夹内文件总数: $totalFilesInNumber 个" -ForegroundColor Green
    }
}
Write-Host ""

# 输出其他开头的文件夹详情
Write-Host "【其他开头的文件夹及其文件】 (共 $($foldersByOther.Count) 个文件夹)" -ForegroundColor Blue
Write-Host "---" -ForegroundColor Blue
if ($foldersByOther.Count -eq 0) {
    Write-Host "  (没有找到其他开头的文件夹)"
}
else {
    $totalFilesInOther = 0
    $foldersWithFiles = 0
    $foldersByOther.Keys | Sort-Object | ForEach-Object {
        if ($foldersByOther[$_].Count -gt 0) {
            Write-Host "  📁 $_" -ForegroundColor Blue
            $totalFilesInOther += $foldersByOther[$_].Count
            $foldersWithFiles += 1
            $foldersByOther[$_] | ForEach-Object {
                Write-Host "     ├─ $_"
            }
        }
    }
    if ($totalFilesInOther -gt 0) {
        Write-Host "  其他开头文件夹内文件总数: $totalFilesInOther 个 (包含文件的文件夹: $foldersWithFiles 个)" -ForegroundColor Green
    }
}
Write-Host ""

# 输出总结
Write-Host "================================================" -ForegroundColor Cyan
Write-Host "总结统计：" -ForegroundColor Cyan
Write-Host "  数字开头文件夹: $($foldersByNumber.Count) 个" -ForegroundColor Magenta
Write-Host "  其他开头文件夹: $($foldersByOther.Count) 个" -ForegroundColor Blue
Write-Host "  文件总计: $($allFiles.Count) 个" -ForegroundColor Cyan
Write-Host "================================================" -ForegroundColor Cyan

# 导出到文本文件
$outputFile = "D:\project\y_project\pages\文件统计结果.txt"
$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

$report = "文件统计报告`n"
$report += "生成时间: $timestamp`n"
$report += "文件夹: $folderPath`n"
$report += "========================================`n`n"

$report += "【数字开头的文件夹及其文件】 (共 $($foldersByNumber.Count) 个文件夹)`n"
$report += "---`n"
if ($foldersByNumber.Count -eq 0) {
    $report += "(没有找到数字开头的文件夹)`n"
}
else {
    $totalFilesInNumber = 0
    $foldersByNumber.Keys | Sort-Object | ForEach-Object {
        if ($foldersByNumber[$_].Count -gt 0) {
            $report += "📁 $_`n"
            $totalFilesInNumber += $foldersByNumber[$_].Count
            $foldersByNumber[$_] | ForEach-Object {
                $report += "   ├─ $_`n"
            }
        }
    }
    if ($totalFilesInNumber -gt 0) {
        $report += "`n数字开头文件夹内文件总数: $totalFilesInNumber 个`n`n"
    }
}

$report += "【其他开头的文件夹及其文件】 (共 $($foldersByOther.Count) 个文件夹)`n"
$report += "---`n"
if ($foldersByOther.Count -eq 0) {
    $report += "(没有找到其他开头的文件夹)`n"
}
else {
    $totalFilesInOther = 0
    $foldersWithFiles = 0
    $foldersByOther.Keys | Sort-Object | ForEach-Object {
        if ($foldersByOther[$_].Count -gt 0) {
            $report += "📁 $_`n"
            $totalFilesInOther += $foldersByOther[$_].Count
            $foldersWithFiles += 1
            $foldersByOther[$_] | ForEach-Object {
                $report += "   ├─ $_`n"
            }
        }
    }
    if ($totalFilesInOther -gt 0) {
        $report += "`n其他开头文件夹内文件总数: $totalFilesInOther 个 (包含文件的文件夹: $foldersWithFiles 个)`n`n"
    }
}

$report += "========================================`n"
$report += "总结统计：`n"
$report += "  数字开头文件夹: $($foldersByNumber.Count) 个`n"
$report += "  其他开头文件夹: $($foldersByOther.Count) 个`n"
$report += "  文件总计: $($allFiles.Count) 个`n"

$report | Out-File -FilePath $outputFile -Encoding UTF8
Write-Host ""
Write-Host "✓ 统计结果已保存到: $outputFile" -ForegroundColor Green